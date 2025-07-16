import SwiftUI
import Combine

@MainActor
class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var colorScheme: ColorScheme = .light
    
    private let settingsUseCase: SettingsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(settingsUseCase: SettingsUseCaseProtocol) {
        self.settingsUseCase = settingsUseCase
        loadCurrentTheme()
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
        updateColorScheme()
        saveThemePreference()
    }
    
    func setDarkMode(_ enabled: Bool) {
        isDarkMode = enabled
        updateColorScheme()
        saveThemePreference()
    }
    
    private func updateColorScheme() {
        withAnimation(.easeInOut(duration: 0.3)) {
            colorScheme = isDarkMode ? .dark : .light
        }
    }
    
    private func loadCurrentTheme() {
        do {
            let settings = try settingsUseCase.getSettings()
            isDarkMode = settings.darkModeEnabled
            updateColorScheme()
        } catch {
            print("Error loading theme: \(error)")
            isDarkMode = false
            updateColorScheme()
        }
    }
    
    private func saveThemePreference() {
        do {
            _ = try settingsUseCase.updateDarkModeSettings(isDarkMode)
        } catch {
            print("Error saving theme preference: \(error)")
        }
    }
}
