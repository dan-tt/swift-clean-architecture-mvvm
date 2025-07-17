import SwiftUI
import Combine

@MainActor
class SplashCoordinator: ObservableObject {
    @Published var isSplashVisible = true
    
    private let diContainer: DIContainer
    private var splashViewModel: SplashViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    func startSplashProcess() {
        splashViewModel = SplashViewModel(diContainer: diContainer)
        splashViewModel?.startSplash()
        
        // Observe splash completion
        splashViewModel?.$isSplashComplete
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (isComplete: Bool) in
                if isComplete {
                    self?.hideSplash()
                }
            }
            .store(in: &cancellables)
    }
    
    func completeSplash() {
        hideSplash()
    }
    
    private func hideSplash() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isSplashVisible = false
        }
    }
}
