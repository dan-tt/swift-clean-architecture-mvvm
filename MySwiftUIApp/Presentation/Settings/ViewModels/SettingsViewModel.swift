import Foundation
import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var settings: AppSettings = AppSettings()
    @Published var errorMessage: String?
    
    private let settingsUseCase: SettingsUseCaseProtocol
    
    init(settingsUseCase: SettingsUseCaseProtocol) {
        self.settingsUseCase = settingsUseCase
        loadSettings()
    }
    
    func toggleNotifications() {
        do {
            settings = try settingsUseCase.updateNotificationSettings(!settings.notificationsEnabled)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func toggleDarkMode(themeManager: ThemeManager) {
        do {
            settings = try settingsUseCase.updateDarkModeSettings(!settings.darkModeEnabled)
            themeManager.setDarkMode(settings.darkModeEnabled)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func loadSettings() {
        do {
            settings = try settingsUseCase.getSettings()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
