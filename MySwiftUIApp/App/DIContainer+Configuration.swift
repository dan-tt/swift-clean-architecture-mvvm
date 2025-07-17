import Foundation

extension DIContainer {
    // MARK: - Debug Configuration
    enum Configuration {
        case debug
        case release
        case testing
        
        var isUsingMockData: Bool {
            switch self {
            case .debug, .testing:
                return true
            case .release:
                return false
            }
        }
    }
    
    // MARK: - Environment Detection
    static var currentConfiguration: Configuration {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
    
    // MARK: - Dynamic Configuration
    static func configure(for configuration: Configuration) -> DIContainer {
        // Since DIContainer uses singleton pattern, we return the shared instance
        // The configuration is determined by the build environment
        return DIContainer.shared
    }
    
    // MARK: - Runtime Configuration Override
    private static var _overrideConfiguration: Configuration?
    
    static func setConfigurationOverride(_ configuration: Configuration?) {
        _overrideConfiguration = configuration
    }
    
    static var effectiveConfiguration: Configuration {
        return _overrideConfiguration ?? currentConfiguration
    }
    
    // MARK: - Testing Support
    static func configureForTesting() -> DIContainer {
        setConfigurationOverride(.testing)
        return DIContainer.shared
    }
    
    static func resetConfiguration() {
        setConfigurationOverride(nil)
    }
}

// MARK: - Convenience Methods
extension DIContainer {
    func logCurrentConfiguration() {
        let config = Self.effectiveConfiguration
        let isOverridden = Self._overrideConfiguration != nil
        print("🔧 DIContainer Configuration:")
        print("   - Environment: \(config)\(isOverridden ? " (OVERRIDDEN)" : "")")
        print("   - Mock Data: \(config.isUsingMockData ? "✅ ENABLED" : "❌ DISABLED")")
        print("   - Network Calls: \(config.isUsingMockData ? "❌ DISABLED" : "✅ ENABLED")")
        if isOverridden {
            print("   - Original: \(Self.currentConfiguration)")
        }
    }
}
