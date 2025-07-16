import Foundation

// Data Transfer Objects for API responses
struct UserDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: CompanyDTO
    
    struct CompanyDTO: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

// Extensions to convert DTOs to Domain entities
extension UserDTO {
    func toDomain() -> UserEntity {
        return UserEntity(
            id: id,
            name: name,
            email: email,
            phone: phone,
            website: website,
            company: UserEntity.Company(
                name: company.name,
                catchPhrase: company.catchPhrase,
                bs: company.bs
            )
        )
    }
}

extension Array where Element == UserDTO {
    func toDomain() -> [UserEntity] {
        return self.map { $0.toDomain() }
    }
}
