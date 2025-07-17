import Foundation

protocol MockDataManagerProtocol {
    func getUserMockData() -> [UserEntity]
    func getUser(by id: Int) -> UserEntity?
    func getRandomUsers(count: Int) -> [UserEntity]
}

class MockDataManager: MockDataManagerProtocol {
    static let shared = MockDataManager()
    
    private init() {}
    
    func getUserMockData() -> [UserEntity] {
        return UserMockData.getUsers()
    }
    
    func getUser(by id: Int) -> UserEntity? {
        return UserMockData.getUser(by: id)
    }
    
    func getRandomUsers(count: Int = 5) -> [UserEntity] {
        return UserMockData.getRandomUsers(count: count)
    }
}

// MARK: - Mock Data Configuration
extension MockDataManager {
    enum MockDataType {
        case users
        case counter
        case settings
    }
    
    func isAvailable(for type: MockDataType) -> Bool {
        switch type {
        case .users:
            return !UserMockData.getUsers().isEmpty
        case .counter:
            return true // Counter mock data is always available
        case .settings:
            return true // Settings mock data is always available
        }
    }
    
    func logMockDataStatus() {
        print("📊 Mock Data Status:")
        print("   - Users: \(UserMockData.getUsers().count) entries")
        print("   - Counter: ✅ Available")
        print("   - Settings: ✅ Available")
    }
}
