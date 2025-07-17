import SwiftUI

// MARK: - Navigation Destinations
enum NavigationDestination: Hashable {
    case userDetail(UserEntity)
    case userList
    case counter
    case settings
    case home
    
    // MARK: - Hashable Conformance
    func hash(into hasher: inout Hasher) {
        switch self {
        case .userDetail(let user):
            hasher.combine("userDetail")
            hasher.combine(user.id)
        case .userList:
            hasher.combine("userList")
        case .counter:
            hasher.combine("counter")
        case .settings:
            hasher.combine("settings")
        case .home:
            hasher.combine("home")
        }
    }
    
    // MARK: - Equatable Conformance
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.userDetail(let userA), .userDetail(let userB)):
            return userA.id == userB.id
        case (.userList, .userList),
             (.counter, .counter),
             (.settings, .settings),
             (.home, .home):
            return true
        default:
            return false
        }
    }
}

// MARK: - Navigation Router
@MainActor
class NavigationRouter: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var selectedTab: AppTab = .home
    
    // MARK: - Navigation Methods
    func navigate(to destination: NavigationDestination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func popToRoot() {
        navigationPath = NavigationPath()
    }
    
    // MARK: - Tab Navigation
    func switchTab(to tab: AppTab) {
        selectedTab = tab
        // Clear navigation stack when switching tabs
        navigationPath = NavigationPath()
    }
    
    // MARK: - Deep Linking Support
    func handleDeepLink(url: URL) {
        // Handle deep links here
        // Example: myapp://user/123
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }
        
        let path = components.path
        
        if path.starts(with: "/user/") {
            let userIdString = String(path.dropFirst(6)) // Remove "/user/"
            if let userId = Int(userIdString) {
                // Navigate to user detail
                // This would require fetching the user entity first
                print("Deep link to user: \(userId)")
            }
        }
    }
}

// MARK: - App Tabs
enum AppTab: String, CaseIterable {
    case home = "Home"
    case counter = "Counter"
    case users = "Users"
    case settings = "Settings"
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .counter: return "plus.circle"
        case .users: return "person.3"
        case .settings: return "gear"
        }
    }
}

// MARK: - Navigation Router Extension
extension NavigationRouter {
    // Convenience methods for specific navigation
    func navigateToUserDetail(_ user: UserEntity) {
        navigate(to: .userDetail(user))
    }
    
    func navigateToUserList() {
        switchTab(to: .users)
    }
    
    func navigateToCounter() {
        switchTab(to: .counter)
    }
    
    func navigateToSettings() {
        switchTab(to: .settings)
    }
    
    func navigateToHome() {
        switchTab(to: .home)
    }
}
