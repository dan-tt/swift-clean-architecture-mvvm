import Foundation
import SwiftUI

struct InfoRowViewModel {
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

// MARK: - Display Properties
extension InfoRowViewModel {
    var displayValue: String {
        return value.isEmpty ? "Not available" : value
    }
    
    var valueColor: Color {
        return value.isEmpty ? Color.theme.tertiaryText : Color.theme.primaryText
    }
    
    var isValueEmpty: Bool {
        return value.isEmpty
    }
    
    var titleColor: Color {
        return Color.theme.secondaryText
    }
}

// MARK: - Factory Methods
extension InfoRowViewModel {
    static func companyName(_ value: String) -> InfoRowViewModel {
        return InfoRowViewModel(title: "Company Name", value: value)
    }
    
    static func catchPhrase(_ value: String) -> InfoRowViewModel {
        return InfoRowViewModel(title: "Catch Phrase", value: value)
    }
    
    static func business(_ value: String) -> InfoRowViewModel {
        return InfoRowViewModel(title: "Business", value: value)
    }
    
    static func address(_ value: String) -> InfoRowViewModel {
        return InfoRowViewModel(title: "Address", value: value)
    }
    
    static func username(_ value: String) -> InfoRowViewModel {
        return InfoRowViewModel(title: "Username", value: value)
    }
}
