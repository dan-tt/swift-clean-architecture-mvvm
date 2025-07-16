import SwiftUI

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
