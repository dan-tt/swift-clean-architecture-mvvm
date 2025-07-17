import Foundation

// MARK: - Section Extensions for Easy Creation
extension DetailSection {
    // Custom section for user preferences
    static func preferencesSection(items: [InfoRowViewModel]) -> DetailSection {
        return DetailSection(
            headerTitle: "Preferences",
            items: items.map { .info($0) },
            configuration: SectionConfiguration(
                showCard: true,
                spacing: 10,
                horizontalPadding: 20
            )
        )
    }
    
    // Custom section for social media
    static func socialMediaSection(items: [ContactRowViewModel]) -> DetailSection {
        return DetailSection(
            headerTitle: "Social Media",
            items: items.map { .contact($0) },
            configuration: SectionConfiguration(
                showCard: false,
                spacing: 14,
                horizontalPadding: 16
            )
        )
    }
    
    // Custom section for achievements
    static func achievementsSection(items: [InfoRowViewModel]) -> DetailSection {
        return DetailSection(
            headerTitle: "Achievements",
            items: items.map { .info($0) },
            configuration: SectionConfiguration(
                showCard: true,
                spacing: 8,
                horizontalPadding: 16
            )
        )
    }
}

// MARK: - Example Usage Documentation
/*
 Usage Example:
 
 // In UserDetailViewModel, you can easily add new sections:
 
 private var socialMediaItems: [ContactRowViewModel] {
     return [
         ContactRowViewModel(icon: "globe", title: "LinkedIn", value: "@johndoe", action: openLinkedIn),
         ContactRowViewModel(icon: "camera", title: "Instagram", value: "@john.doe", action: openInstagram)
     ]
 }
 
 private var achievementsItems: [InfoRowViewModel] {
     return [
         InfoRowViewModel(title: "Years of Experience", value: "5+"),
         InfoRowViewModel(title: "Projects Completed", value: "50+"),
         InfoRowViewModel(title: "Team Size", value: "10")
     ]
 }
 
 // Then in your sections computed property:
 var sections: [DetailSection] {
     var sections: [DetailSection] = []
     
     // Standard sections
     sections.append(DetailSection.contactSection(items: contactRowViewModels))
     
     if hasPersonalInfo {
         sections.append(DetailSection.personalInfoSection(items: personalInfoRowViewModels))
     }
     
     // New custom sections
     sections.append(DetailSection.socialMediaSection(items: socialMediaItems))
     sections.append(DetailSection.achievementsSection(items: achievementsItems))
     
     if hasCompanyInfo {
         sections.append(DetailSection.companySection(items: companyInfoRowViewModels))
     }
     
     return sections
 }
 
 Benefits of this approach:
 - Easy to add new sections without modifying the view
 - Consistent styling through configuration
 - Type-safe section management
 - Reusable section components
 - Clean separation of concerns
 - Testable section logic
 */
