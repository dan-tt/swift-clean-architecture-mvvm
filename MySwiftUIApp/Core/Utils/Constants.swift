import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://jsonplaceholder.typicode.com"
        static let usersEndpoint = "/users"
    }
    
    struct Storage {
        static let counterKey = "counter_value"
        static let settingsKey = "user_settings"
    }
    
    struct App {
        static let version = "1.0.0"
        static let build = "1"
    }
}
