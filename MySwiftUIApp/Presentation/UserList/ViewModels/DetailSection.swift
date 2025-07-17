import Foundation
import CoreGraphics

// MARK: - Section Model
struct DetailSection: Identifiable {
    let id = UUID()
    let headerTitle: String
    let items: [DetailItem]
    let configuration: SectionConfiguration
    
    init(headerTitle: String, items: [DetailItem], configuration: SectionConfiguration = .default) {
        self.headerTitle = headerTitle
        self.items = items
        self.configuration = configuration
    }
}

// MARK: - Item Model
enum DetailItem: Identifiable {
    case contact(ContactRowViewModel)
    case info(InfoRowViewModel)
    
    var id: String {
        switch self {
        case .contact(let viewModel):
            return "contact_\(viewModel.title)_\(viewModel.value)"
        case .info(let viewModel):
            return "info_\(viewModel.title)_\(viewModel.value)"
        }
    }
}

// MARK: - Section Configuration
struct SectionConfiguration {
    let showCard: Bool
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    
    static let `default` = SectionConfiguration(
        showCard: true,
        spacing: 12,
        horizontalPadding: 16
    )
    
    static let contactStyle = SectionConfiguration(
        showCard: false,
        spacing: 16,
        horizontalPadding: 16
    )
}

// MARK: - Section Factory Methods
extension DetailSection {
    static func contactSection(items: [ContactRowViewModel]) -> DetailSection {
        return DetailSection(
            headerTitle: "Contact Information",
            items: items.map { .contact($0) },
            configuration: .contactStyle
        )
    }
    
    static func companySection(items: [InfoRowViewModel]) -> DetailSection {
        return DetailSection(
            headerTitle: "Company",
            items: items.map { .info($0) },
            configuration: .default
        )
    }
}

// MARK: - Section Helpers
extension DetailSection {
    var hasItems: Bool {
        return !items.isEmpty
    }
    
    var contactItems: [ContactRowViewModel] {
        return items.compactMap { item in
            if case .contact(let viewModel) = item {
                return viewModel
            }
            return nil
        }
    }
    
    var infoItems: [InfoRowViewModel] {
        return items.compactMap { item in
            if case .info(let viewModel) = item {
                return viewModel
            }
            return nil
        }
    }
}
