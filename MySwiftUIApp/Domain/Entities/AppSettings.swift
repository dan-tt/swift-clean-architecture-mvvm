import Foundation

struct AppSettings: Codable {
    var notificationsEnabled: Bool
    var darkModeEnabled: Bool
    
    init(notificationsEnabled: Bool = true, darkModeEnabled: Bool = false) {
        self.notificationsEnabled = notificationsEnabled
        self.darkModeEnabled = darkModeEnabled
    }
}
