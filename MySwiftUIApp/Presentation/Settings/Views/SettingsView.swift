import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    init(viewModel: SettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Preferences") {
                    Toggle("Enable Notifications", isOn: Binding(
                        get: { viewModel.settings.notificationsEnabled },
                        set: { _ in viewModel.toggleNotifications() }
                    ))
                    
                    Toggle("Dark Mode", isOn: Binding(
                        get: { viewModel.settings.darkModeEnabled },
                        set: { _ in viewModel.toggleDarkMode(themeManager: themeManager) }
                    ))
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Constants.App.version)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                    
                    HStack {
                        Text("Build")
                        Spacer()
                        Text(Constants.App.build)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
                
                Section("Support") {
                    Link("Report a Bug", destination: URL(string: "https://github.com")!)
                    Link("Contact Support", destination: URL(string: "mailto:support@example.com")!)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Section("Error") {
                        Text(errorMessage)
                            .foregroundColor(Color.theme.error)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let storageService = UserDefaultsStorageService()
        let repository = SettingsRepository(storageService: storageService)
        let useCase = SettingsUseCase(repository: repository)
        let viewModel = SettingsViewModel(settingsUseCase: useCase)
        
        SettingsView(viewModel: viewModel)
    }
}
