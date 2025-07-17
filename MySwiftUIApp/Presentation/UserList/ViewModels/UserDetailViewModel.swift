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
    
    private var displayEmail: String {
        return user.email
    }
    
    private var displayPhone: String {
        return user.phone
    }
    
    private var displayWebsite: String {
        return user.website.hasPrefix("http") ? user.website : "https://\(user.website)"
    }
    
    private var displayCompanyName: String {
        return user.company.name
    }
    
    private var displayCompanyCatchPhrase: String {
        return user.company.catchPhrase
    }
    
    private var displayCompanyBusiness: String {
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

    // MARK: - Sections
    var sections: [DetailSection] {
        var sections: [DetailSection] = []
        
        // Contact Section
        let contactSection = DetailSection.contactSection(items: contactRowViewModels)
        sections.append(contactSection)
        
        // Company Section
        if hasCompanyInfo {
            let companySection = DetailSection.companySection(items: companyInfoRowViewModels)
            sections.append(companySection)
        }
        
        return sections
    }
    
    // MARK: - Contact Row View Models
    private var contactRowViewModels: [ContactRowViewModel] {
        return [
            .email(value: displayEmail, action: sendEmail),
            .phone(value: displayPhone, action: callPhone),
            .website(value: displayWebsite, action: openWebsite)
        ]
    }
    
    // MARK: - Info Row View Models
    private var companyInfoRowViewModels: [InfoRowViewModel] {
        return [
            .companyName(displayCompanyName),
            .catchPhrase(displayCompanyCatchPhrase),
            .business(displayCompanyBusiness)
        ]
    }
    
    // MARK: - Additional Sections
    private var additionalSections: [DetailSection] {
        var sections: [DetailSection] = []
        
        // Add a custom section for user statistics if needed
        if shouldShowStatistics {
            let statisticsSection = DetailSection(
                headerTitle: "Statistics",
                items: [
                    .info(InfoRowViewModel(title: "Profile Views", value: "1,234")),
                    .info(InfoRowViewModel(title: "Last Login", value: "2 hours ago")),
                    .info(InfoRowViewModel(title: "Member Since", value: "January 2023"))
                ],
                configuration: SectionConfiguration(
                    showCard: true,
                    spacing: 8,
                    horizontalPadding: 16
                )
            )
            sections.append(statisticsSection)
        }
        
        return sections
    }
    
    private var shouldShowStatistics: Bool {
        // This could be based on user preferences, feature flags, etc.
        return false // Disabled for now
    }
    
    // MARK: - Enhanced Sections with Additional Features
    var enhancedSections: [DetailSection] {
        var allSections = sections
        allSections.append(contentsOf: additionalSections)
        return allSections
    }
    
    // MARK: - Section Helpers
    var hasCompanyInfo: Bool {
        return !user.company.name.isEmpty || !user.company.catchPhrase.isEmpty || !user.company.bs.isEmpty
    }
    
    // MARK: - Section Management
    func sectionForType(_ type: SectionType) -> DetailSection? {
        return sections.first { section in
            switch type {
            case .contact:
                return section.headerTitle == "Contact Information"
            case .company:
                return section.headerTitle == "Company"
            }
        }
    }
    
    func hasSectionOfType(_ type: SectionType) -> Bool {
        return sectionForType(type) != nil
    }
    
    enum SectionType {
        case contact
        case company
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
