import Foundation
import SwiftUI

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [UserEntity] = []
    @Published var userRowViewModels: [UserRowViewModel] = []
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
            userRowViewModels = UserRowViewModel.from(users)
        } catch {
            errorMessage = error.localizedDescription
            users = []
            userRowViewModels = []
        }
        
        isLoading = false
    }
    
    func refreshUsers() async {
        await fetchUsers()
    }
    
    // MARK: - Computed Properties
    var hasUsers: Bool {
        return !userRowViewModels.isEmpty
    }
    
    var userCount: Int {
        return userRowViewModels.count
    }
    
    var isError: Bool {
        return errorMessage != nil
    }
    
    // MARK: - Helper Methods
    func getUserRowViewModel(for id: Int) -> UserRowViewModel? {
        return userRowViewModels.first { $0.id == id }
    }
    
    func getUserEntity(for id: Int) -> UserEntity? {
        return users.first { $0.id == id }
    }
    
    func clearError() {
        errorMessage = nil
    }
}
