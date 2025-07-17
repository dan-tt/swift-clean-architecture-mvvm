import Foundation

struct UserEntity: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: Company
    
    struct Company: Codable, Equatable, Hashable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
