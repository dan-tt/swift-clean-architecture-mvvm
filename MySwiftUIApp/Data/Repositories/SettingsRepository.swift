import Foundation

class SettingsRepository: SettingsRepositoryProtocol {
    private let storageService: StorageServiceProtocol
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func saveSettings(_ settings: AppSettings) throws {
        try storageService.save(settings, for: Constants.Storage.settingsKey)
    }
    
    func loadSettings() throws -> AppSettings {
        return try storageService.load(AppSettings.self, for: Constants.Storage.settingsKey)
    }
}
