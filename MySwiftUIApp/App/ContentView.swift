import SwiftUI

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            CounterView(viewModel: DIContainer.shared.makeCounterViewModel())
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Counter")
                }
            
            UserListView(viewModel: DIContainer.shared.makeUserListViewModel())
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Users")
                }
            
            SettingsView(viewModel: DIContainer.shared.makeSettingsViewModel())
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DIContainer.shared.themeManager)
    }
}
