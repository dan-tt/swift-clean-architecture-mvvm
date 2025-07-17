import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

struct ContactRowViewModel {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void
    
    init(icon: String, title: String, value: String, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.value = value
        self.action = action
    }
}

// MARK: - Factory Methods
extension ContactRowViewModel {
    static func email(value: String, action: @escaping () -> Void) -> ContactRowViewModel {
        return ContactRowViewModel(
            icon: "envelope.fill",
            title: "Email",
            value: value,
            action: action
        )
    }
    
    static func phone(value: String, action: @escaping () -> Void) -> ContactRowViewModel {
        return ContactRowViewModel(
            icon: "phone.fill",
            title: "Phone",
            value: value,
            action: action
        )
    }
    
    static func website(value: String, action: @escaping () -> Void) -> ContactRowViewModel {
        return ContactRowViewModel(
            icon: "globe",
            title: "Website",
            value: value,
            action: action
        )
    }
}

// MARK: - Display Properties
extension ContactRowViewModel {
    var iconColor: Color {
        switch icon {
        case "envelope.fill":
            return Color.theme.info
        case "phone.fill":
            return Color.theme.success
        case "globe":
            return Color.theme.primary
        default:
            return Color.theme.info
        }
    }
    
    var isActionable: Bool {
        return !value.isEmpty
    }
}
