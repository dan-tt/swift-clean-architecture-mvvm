import Foundation
import SwiftUI

@MainActor
class CounterViewModel: ObservableObject {
    @Published var counter: Counter = Counter()
    @Published var errorMessage: String?
    
    private let counterUseCase: CounterUseCaseProtocol
    
    init(counterUseCase: CounterUseCaseProtocol) {
        self.counterUseCase = counterUseCase
        loadCounter()
    }
    
    func increment() {
        do {
            counter = try counterUseCase.incrementCounter()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func decrement() {
        do {
            counter = try counterUseCase.decrementCounter()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func reset() {
        do {
            counter = try counterUseCase.resetCounter()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func loadCounter() {
        do {
            counter = try counterUseCase.getCounter()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
