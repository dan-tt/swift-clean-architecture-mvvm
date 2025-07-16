import Foundation

protocol FetchUsersUseCaseProtocol {
    func execute() async throws -> [UserEntity]
}

class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [UserEntity] {
        return try await repository.fetchUsers()
    }
}
