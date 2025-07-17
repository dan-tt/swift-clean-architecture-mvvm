import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: AppTab.home.iconName)
                    Text(AppTab.home.rawValue)
                }
                .tag(AppTab.home)
            
            CounterView(viewModel: DIContainer.shared.makeCounterViewModel())
                .tabItem {
                    Image(systemName: AppTab.counter.iconName)
                    Text(AppTab.counter.rawValue)
                }
                .tag(AppTab.counter)
            
            UserListView(viewModel: DIContainer.shared.makeUserListViewModel())
                .tabItem {
                    Image(systemName: AppTab.users.iconName)
                    Text(AppTab.users.rawValue)
                }
                .tag(AppTab.users)
            
            SettingsView(viewModel: DIContainer.shared.makeSettingsViewModel())
                .tabItem {
                    Image(systemName: AppTab.settings.iconName)
                    Text(AppTab.settings.rawValue)
                }
                .tag(AppTab.settings)
        }
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.colorScheme)
        .onAppear {
            configureTabBarAppearance()
        }
        .onChange(of: themeManager.isDarkMode) { _ in
            configureTabBarAppearance()
        }
    }
    
    private func configureTabBarAppearance() {
        #if canImport(UIKit)
        let appearance = UITabBarAppearance()
        
        if themeManager.isDarkMode {
            // Dark mode configuration
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.shadowColor = UIColor.darkGray
            
            // Tab item colors for dark mode
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.systemGray
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
            
            // Badge colors for dark mode
            appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor.systemRed
            appearance.stackedLayoutAppearance.selected.badgeBackgroundColor = UIColor.systemRed
        } else {
            // Light mode configuration
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            appearance.shadowColor = UIColor.systemGray4
            
            // Tab item colors for light mode
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.systemGray
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.systemBlue
            ]
            
            // Badge colors for light mode
            appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor.systemRed
            appearance.stackedLayoutAppearance.selected.badgeBackgroundColor = UIColor.systemRed
        }
        
        // Apply appearance to all tab bar states
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // For iOS 15+ compatibility
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationCoordinator()
            .environmentObject(DIContainer.shared.themeManager)
    }
}
