import Foundation

class UserApiService {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUsers() async throws -> [UserDTO] {
        guard let url = URL(string: Constants.API.baseURL + Constants.API.usersEndpoint) else {
            throw NetworkError.invalidURL
        }
        
        return try await networkService.fetch([UserDTO].self, from: url)
    }
}
