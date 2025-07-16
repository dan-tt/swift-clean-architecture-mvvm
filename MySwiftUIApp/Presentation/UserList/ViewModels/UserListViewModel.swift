import Foundation
import SwiftUI

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [UserEntity] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let fetchUsersUseCase: FetchUsersUseCaseProtocol
    
    init(fetchUsersUseCase: FetchUsersUseCaseProtocol) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        
        do {
            users = try await fetchUsersUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func refreshUsers() async {
        await fetchUsers()
    }
}
