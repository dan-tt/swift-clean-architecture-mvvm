import Foundation
import SwiftUI

struct UserRowViewModel: Identifiable {
    let id: Int
    let displayName: String
    let displayEmail: String
    let displayCompanyInfo: String
    let initials: String
    let backgroundColor: Color
    
    // MARK: - Initializer
    init(from userEntity: UserEntity) {
        self.id = userEntity.id
        self.displayName = userEntity.name
        self.displayEmail = userEntity.email
        self.displayCompanyInfo = "\(userEntity.company.name) - \(userEntity.company.catchPhrase)"
        
        // Generate initials
        let nameComponents = userEntity.name.components(separatedBy: " ")
        let firstInitial = nameComponents.first?.first ?? Character("")
        let lastInitial = nameComponents.count > 1 ? nameComponents.last?.first ?? Character("") : Character("")
        self.initials = "\(firstInitial)\(lastInitial)".uppercased()
        
        // Generate consistent color based on user ID
        let colors: [Color] = [.blue, .green, .orange, .purple, .pink, .red, .yellow, .indigo]
        self.backgroundColor = colors[userEntity.id % colors.count]
    }
}

// MARK: - Static Factory Methods
extension UserRowViewModel {
    static func from(_ userEntity: UserEntity) -> UserRowViewModel {
        return UserRowViewModel(from: userEntity)
    }
    
    static func from(_ userEntities: [UserEntity]) -> [UserRowViewModel] {
        return userEntities.map { UserRowViewModel(from: $0) }
    }
}

// MARK: - Equatable Conformance
extension UserRowViewModel: Equatable {
    static func == (lhs: UserRowViewModel, rhs: UserRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Hashable Conformance
extension UserRowViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
