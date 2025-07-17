import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

@MainActor
class UserDetailViewModel: ObservableObject {
    @Published var user: UserEntity
    
    init(user: UserEntity) {
        self.user = user
    }
    
    // MARK: - Computed Properties
    var displayName: String {
        return user.name
    }
    
    var displayEmail: String {
        return user.email
    }
    
    var displayPhone: String {
        return user.phone
    }
    
    var displayWebsite: String {
        return user.website.hasPrefix("http") ? user.website : "https://\(user.website)"
    }
    
    var displayCompanyName: String {
        return user.company.name
    }
    
    var displayCompanyCatchPhrase: String {
        return user.company.catchPhrase
    }
    
    var displayCompanyBusiness: String {
        return user.company.bs
    }
    
    var initials: String {
        let nameComponents = user.name.components(separatedBy: " ")
        let firstInitial = nameComponents.first?.first ?? Character("")
        let lastInitial = nameComponents.count > 1 ? nameComponents.last?.first ?? Character("") : Character("")
        return "\(firstInitial)\(lastInitial)".uppercased()
    }
    
    var backgroundColor: Color {
        let colors: [Color] = [.blue, .green, .orange, .purple, .pink, .red, .yellow, .indigo]
        return colors[user.id % colors.count]
    }
    
    // MARK: - Actions
    func openWebsite() {
        guard let url = URL(string: displayWebsite) else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
    
    func callPhone() {
        let phoneNumber = user.phone.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        
        guard let url = URL(string: "tel://\(phoneNumber)") else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
    
    func sendEmail() {
        guard let url = URL(string: "mailto:\(user.email)") else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
}
