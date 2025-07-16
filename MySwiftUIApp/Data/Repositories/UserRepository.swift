import Foundation

class UserRepository: UserRepositoryProtocol {
    private let apiService: UserApiService
    
    init(apiService: UserApiService) {
        self.apiService = apiService
    }
    
    func fetchUsers() async throws -> [UserEntity] {
        let userDTOs = try await apiService.fetchUsers()
        return userDTOs.toDomain()
    }
}
