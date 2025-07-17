import SwiftUI

// MARK: - Navigation Coordinator
struct NavigationCoordinator: View {
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            ContentView()
                .navigationDestination(for: NavigationDestination.self) { destination in
                    destinationView(for: destination)
                }
        }
        .environmentObject(router)
    }
    
    // MARK: - Destination View Builder
    @ViewBuilder
    private func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
        case .userDetail(let user):
            UserDetailView(user: user)
        case .userList:
            UserListView(viewModel: DIContainer.shared.makeUserListViewModel())
        case .counter:
            CounterView(viewModel: DIContainer.shared.makeCounterViewModel())
        case .settings:
            SettingsView(viewModel: DIContainer.shared.makeSettingsViewModel())
        case .home:
            HomeView()
        }
    }
}

// MARK: - Navigation Extensions for Views
extension View {
    func withNavigationRouter() -> some View {
        NavigationCoordinator()
    }
}

// MARK: - Navigation Helper Views
struct NavigationButton<Destination: View>: View {
    let title: String
    let destination: NavigationDestination
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        Button(title) {
            router.navigate(to: destination)
        }
    }
}

struct BackButton: View {
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        Button(action: {
            router.navigateBack()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        }
    }
}

struct RootButton: View {
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        Button("Home") {
            router.navigateToHome()
        }
    }
}
