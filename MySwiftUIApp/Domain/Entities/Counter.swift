import Foundation

struct Counter: Codable {
    var value: Int
    
    init(value: Int = 0) {
        self.value = value
    }
    
    mutating func increment() {
        value += 1
    }
    
    mutating func decrement() {
        value -= 1
    }
    
    mutating func reset() {
        value = 0
    }
}
