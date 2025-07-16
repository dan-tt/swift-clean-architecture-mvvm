import Foundation

protocol StorageServiceProtocol {
    func save<T: Codable>(_ object: T, for key: String) throws
    func load<T: Codable>(_ type: T.Type, for key: String) throws -> T
    func delete(for key: String) throws
    func exists(for key: String) -> Bool
}

class UserDefaultsStorageService: StorageServiceProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save<T: Codable>(_ object: T, for key: String) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        userDefaults.set(data, forKey: key)
    }
    
    func load<T: Codable>(_ type: T.Type, for key: String) throws -> T {
        guard let data = userDefaults.data(forKey: key) else {
            throw StorageError.dataNotFound
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
    
    func delete(for key: String) throws {
        userDefaults.removeObject(forKey: key)
    }
    
    func exists(for key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}

enum StorageError: Error, LocalizedError {
    case dataNotFound
    case encodingError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Data not found"
        case .encodingError:
            return "Failed to encode data"
        case .decodingError:
            return "Failed to decode data"
        }
    }
}
