import Foundation

class UserRepositoryMock: UserRepositoryProtocol {
    private let mockDataManager: MockDataManagerProtocol
    
    init(mockDataManager: MockDataManagerProtocol = MockDataManager.shared) {
        self.mockDataManager = mockDataManager
    }
    
    func fetchUsers() async throws -> [UserEntity] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Simulate occasional network failures for testing
        if Bool.random() && shouldSimulateError() {
            throw MockNetworkError.connectionFailed
        }
        
        return mockDataManager.getUserMockData()
    }
    
    func fetchUser(by id: Int) async throws -> UserEntity? {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        return mockDataManager.getUser(by: id)
    }
    
    // MARK: - Error Simulation
    private func shouldSimulateError() -> Bool {
        // 10% chance of simulating an error
        return Int.random(in: 1...10) == 1
    }
}

// MARK: - Mock Network Errors
enum MockNetworkError: Error, LocalizedError {
    case connectionFailed
    case invalidResponse
    case dataCorrupted
    case timeout
    
    var errorDescription: String? {
        switch self {
        case .connectionFailed:
            return "Connection failed. Please check your internet connection."
        case .invalidResponse:
            return "Invalid response from server."
        case .dataCorrupted:
            return "Data corrupted during transmission."
        case .timeout:
            return "Request timed out. Please try again."
        }
    }
}
