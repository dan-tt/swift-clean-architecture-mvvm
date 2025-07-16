import Foundation

class CounterRepository: CounterRepositoryProtocol {
    private let storageService: StorageServiceProtocol
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func saveCounter(_ counter: Counter) throws {
        try storageService.save(counter, for: Constants.Storage.counterKey)
    }
    
    func loadCounter() throws -> Counter {
        return try storageService.load(Counter.self, for: Constants.Storage.counterKey)
    }
}
