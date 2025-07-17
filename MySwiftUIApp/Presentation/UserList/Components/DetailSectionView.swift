import SwiftUI

struct DetailSectionView: View {
    let section: DetailSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: section.configuration.spacing) {
            SectionHeader(title: section.headerTitle)
            
            if section.hasItems {
                switch section.items.first {
                case .contact(_):
                    // Contact section - show items directly
                    ForEach(section.contactItems, id: \.id) { contactViewModel in
                        ContactRow(viewModel: contactViewModel)
                    }
                    
                case .info(_):
                    // Info section - show items with optional card styling
                    let infoContent = VStack(alignment: .leading, spacing: section.configuration.spacing) {
                        ForEach(section.infoItems, id: \.id) { infoViewModel in
                            InfoRow(viewModel: infoViewModel)
                        }
                    }
                    
                    if section.configuration.showCard {
                        infoContent
                            .padding()
                            .background(Color.theme.cardBackground)
                            .cornerRadius(12)
                    } else {
                        infoContent
                    }
                    
                case .none:
                    EmptyView()
                }
            }
        }
        .padding(.horizontal, section.configuration.horizontalPadding)
    }
}

// MARK: - ContactRowViewModel Identifiable
extension ContactRowViewModel: Identifiable {
    var id: String {
        return "\(title)_\(value)"
    }
}

// MARK: - InfoRowViewModel Identifiable
extension InfoRowViewModel: Identifiable {
    var id: String {
        return "\(title)_\(value)"
    }
}

// MARK: - Preview
struct DetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            // Contact section preview
            DetailSectionView(
                section: DetailSection.contactSection(items: [
                    .email(value: "john@example.com", action: {}),
                    .phone(value: "+1 555 123 4567", action: {}),
                    .website(value: "https://johndoe.com", action: {})
                ])
            )
            
            // Info section preview
            DetailSectionView(
                section: DetailSection.companySection(items: [
                    .companyName("Tech Solutions Inc."),
                    .catchPhrase("Innovation at its finest"),
                    .business("revolutionize cutting-edge technologies")
                ])
            )
        }
        .background(Color.theme.background)
    }
}
