import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserListViewModel
    @EnvironmentObject private var router: NavigationRouter
    
    init(viewModel: UserListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView(message: "Loading users...")
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Text("Error")
                        .font(.headline)
                        .foregroundColor(Color.theme.error)
                    
                    Text(errorMessage)
                        .foregroundColor(Color.theme.secondaryText)
                        .multilineTextAlignment(.center)
                    
                    Button("Retry") {
                        Task {
                            await viewModel.fetchUsers()
                        }
                    }
                    .themeButton(style: .primary)
                }
                .padding()
            } else {
                List(viewModel.userRowViewModels) { userRowViewModel in
                    Button(action: {
                        if let user = viewModel.getUserEntity(for: userRowViewModel.id) {
                            router.navigateToUserDetail(user)
                        }
                    }) {
                        UserRowView(viewModel: userRowViewModel)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Users")
        .refreshable {
            await viewModel.refreshUsers()
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        let networkService = NetworkService()
        let apiService = UserApiService(networkService: networkService)
        let repository = UserRepository(apiService: apiService)
        let useCase = FetchUsersUseCase(repository: repository)
        let viewModel = UserListViewModel(fetchUsersUseCase: useCase)
        
        UserListView(viewModel: viewModel)
    }
}
