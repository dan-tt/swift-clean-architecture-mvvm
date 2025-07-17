import SwiftUI

@main
struct MySwiftUIApp: App {
    @StateObject private var themeManager = DIContainer.shared.themeManager
    @StateObject private var splashCoordinator = SplashCoordinator(diContainer: DIContainer.shared)
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Main app content
                NavigationCoordinator()
                    .environmentObject(themeManager)
                    .preferredColorScheme(themeManager.colorScheme)
                
                // Splash screen overlay
                if splashCoordinator.isSplashVisible {
                    SplashView {
                        splashCoordinator.completeSplash()
                    }
                    .transition(.opacity)
                    .zIndex(1)
                }
            }
            .onAppear {
                splashCoordinator.startSplashProcess()
            }
        }
    }
}
