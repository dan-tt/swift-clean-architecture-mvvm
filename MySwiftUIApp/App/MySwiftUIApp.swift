import SwiftUI

@main
struct MySwiftUIApp: App {
    @StateObject private var themeManager = DIContainer.shared.themeManager
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
