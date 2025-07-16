import Foundation

protocol SettingsUseCaseProtocol {
    func getSettings() throws -> AppSettings
    func saveSettings(_ settings: AppSettings) throws
    func updateNotificationSettings(_ enabled: Bool) throws -> AppSettings
    func updateDarkModeSettings(_ enabled: Bool) throws -> AppSettings
}

class SettingsUseCase: SettingsUseCaseProtocol {
    private let repository: SettingsRepositoryProtocol
    
    init(repository: SettingsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getSettings() throws -> AppSettings {
        do {
            return try repository.loadSettings()
        } catch {
            return AppSettings()
        }
    }
    
    func saveSettings(_ settings: AppSettings) throws {
        try repository.saveSettings(settings)
    }
    
    func updateNotificationSettings(_ enabled: Bool) throws -> AppSettings {
        var settings = try getSettings()
        settings.notificationsEnabled = enabled
        try repository.saveSettings(settings)
        return settings
    }
    
    func updateDarkModeSettings(_ enabled: Bool) throws -> AppSettings {
        var settings = try getSettings()
        settings.darkModeEnabled = enabled
        try repository.saveSettings(settings)
        return settings
    }
}
