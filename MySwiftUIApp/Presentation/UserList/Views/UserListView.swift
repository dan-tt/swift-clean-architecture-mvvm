import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
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
                        UserRowView(viewModel: userRowViewModel)
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
