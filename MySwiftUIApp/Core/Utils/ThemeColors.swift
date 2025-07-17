import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

extension Color {
    // MARK: - Theme Colors
    static let theme = ThemeColors()
}

struct ThemeColors {
    // MARK: - Primary Colors
    let primary = Color.accentColor
    let background = Color.primary
    let secondaryBackground = Color.secondary
    let tertiaryBackground = Color.gray.opacity(0.1)
    
    // MARK: - Text Colors
    let primaryText = Color.primary
    let secondaryText = Color.secondary
    let tertiaryText = Color.gray
    
    // MARK: - Semantic Colors
    let success = Color.green
    let warning = Color.orange
    let error = Color.red
    let info = Color.blue
    
    // MARK: - Card Colors
    let cardBackground = Color.gray.opacity(0.1)
    let cardShadow = Color.black.opacity(0.1)
    
    // MARK: - Interactive Colors
    let buttonBackground = Color.blue
    let buttonForeground = Color.white
    let linkColor = Color.blue
    
    // MARK: - Tab Bar Colors
    #if canImport(UIKit)
    let tabBarBackground = Color(UIColor.systemBackground)
    #else
    let tabBarBackground = Color.primary
    #endif
    let tabBarSelectedItem = Color.accentColor
    let tabBarUnselectedItem = Color.gray
    let tabBarShadow = Color.black.opacity(0.1)
}

// MARK: - Theme-aware View Modifiers
struct ThemeCardModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(Color.theme.cardBackground)
            .cornerRadius(12)
            .shadow(
                color: Color.theme.cardShadow,
                radius: colorScheme == .dark ? 0 : 4,
                x: 0,
                y: colorScheme == .dark ? 0 : 2
            )
    }
}

struct ThemeButtonModifier: ViewModifier {
    let style: ThemeButtonStyle
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(style.backgroundColor)
            .foregroundColor(style.foregroundColor)
            .cornerRadius(8)
    }
}

enum ThemeButtonStyle {
    case primary
    case secondary
    case destructive
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Color.theme.buttonBackground
        case .secondary:
            return Color.theme.secondaryBackground
        case .destructive:
            return Color.theme.error
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary:
            return Color.theme.buttonForeground
        case .secondary:
            return Color.theme.primaryText
        case .destructive:
            return Color.white
        }
    }
}

// MARK: - View Extensions
extension View {
    func themeCard() -> some View {
        modifier(ThemeCardModifier())
    }
    
    func themeButton(style: ThemeButtonStyle = .primary) -> some View {
        modifier(ThemeButtonModifier(style: style))
    }
}
