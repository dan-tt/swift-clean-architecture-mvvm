import Foundation

protocol CounterUseCaseProtocol {
    func getCounter() throws -> Counter
    func incrementCounter() throws -> Counter
    func decrementCounter() throws -> Counter
    func resetCounter() throws -> Counter
}

class CounterUseCase: CounterUseCaseProtocol {
    private let repository: CounterRepositoryProtocol
    
    init(repository: CounterRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCounter() throws -> Counter {
        do {
            return try repository.loadCounter()
        } catch {
            return Counter()
        }
    }
    
    func incrementCounter() throws -> Counter {
        var counter = try getCounter()
        counter.increment()
        try repository.saveCounter(counter)
        return counter
    }
    
    func decrementCounter() throws -> Counter {
        var counter = try getCounter()
        counter.decrement()
        try repository.saveCounter(counter)
        return counter
    }
    
    func resetCounter() throws -> Counter {
        var counter = try getCounter()
        counter.reset()
        try repository.saveCounter(counter)
        return counter
    }
}
