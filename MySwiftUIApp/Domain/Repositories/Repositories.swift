import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [UserEntity]
}

protocol CounterRepositoryProtocol {
    func saveCounter(_ counter: Counter) throws
    func loadCounter() throws -> Counter
}

protocol SettingsRepositoryProtocol {
    func saveSettings(_ settings: AppSettings) throws
    func loadSettings() throws -> AppSettings
}
