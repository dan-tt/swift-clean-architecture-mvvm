import Foundation
import SwiftUI

// MARK: - Navigation Extensions
extension UserListViewModel {
    func navigateToUserDetail(_ user: UserEntity, using router: NavigationRouter) {
        router.navigateToUserDetail(user)
    }
    
    func navigateToUserDetail(for id: Int, using router: NavigationRouter) {
        if let user = getUserEntity(for: id) {
            router.navigateToUserDetail(user)
        }
    }
}

// MARK: - Navigation Helper for UserDetailView
extension UserDetailView {
    static func make(for user: UserEntity) -> UserDetailView {
        return UserDetailView(user: user)
    }
}

// MARK: - Navigation State Management
extension NavigationRouter {
    var canGoBack: Bool {
        !navigationPath.isEmpty
    }
    
    var currentDestination: NavigationDestination? {
        // This would require implementing a way to track current destination
        // For now, we'll return nil
        return nil
    }
    
    func navigateToUserListTab() {
        switchTab(to: .users)
    }
    
    func navigateToCounterTab() {
        switchTab(to: .counter)
    }
    
    func navigateToSettingsTab() {
        switchTab(to: .settings)
    }
    
    func navigateToHomeTab() {
        switchTab(to: .home)
    }
}
