# SwiftUI Clean Architecture MVVM

A modern iOS application built with SwiftUI and Swift Package Manager, showcasing Clean Architecture principles with MVVM pattern, centralized navigation, dark mode support, and comprehensive examples of SwiftUI capabilities.

## 🏗️ Architecture Overview

This project demonstrates a robust, scalable architecture following Clean Architecture principles:

```
┌─────────────────────────────────────────────────────────────┐
│                        App Layer                            │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────── │
│  │   ContentView   │  │  DIContainer    │  │  MySwiftUIApp  │
│  └─────────────────┘  └─────────────────┘  └─────────────── │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────│
│  │  ViewModels  │  │    Views     │  │     Components      │
│  │   (MVVM)     │  │  (SwiftUI)   │  │   (Reusable UI)     │
│  └──────────────┘  └──────────────┘  └──────────────────────│
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                     Domain Layer                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────│
│  │   Entities   │  │  Use Cases   │  │    Repositories     │
│  │  (Models)    │  │ (Business)   │  │   (Interfaces)      │
│  └──────────────┘  └──────────────┘  └──────────────────────│
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────│
│  │ Repositories │  │   Network    │  │   Storage/Mock      │
│  │ (Concrete)   │  │  (API/DTOs)  │  │   (Data Sources)    │
│  └──────────────┘  └──────────────┘  └──────────────────────│
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                       Core Layer                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────│
│  │  Navigation  │  │    Utils     │  │      Network        │
│  │   (Router)   │  │  (Themes)    │  │    (Services)       │
│  └──────────────┘  └──────────────┘  └──────────────────────│
└─────────────────────────────────────────────────────────────┘
```

## ✨ Features

### 🎯 Core Architecture
- **Clean Architecture**: Separation of concerns with distinct layers
- **MVVM Pattern**: ViewModels handle business logic and state management
- **Dependency Injection**: Centralized DI container for loose coupling
- **Repository Pattern**: Abstraction layer for data access
- **Use Cases**: Encapsulated business logic operations

### 🎨 User Interface
- **SwiftUI**: Modern declarative UI framework
- **TabView Navigation**: Multi-tab interface with Home, Users, Counter, Settings
- **Dark Mode Support**: System-wide dark/light mode with custom theme management
- **Custom Components**: Reusable UI components and view modifiers
- **Responsive Design**: Adaptive layouts for iPhone and iPad

### 🔄 Navigation System
- **Centralized Navigation**: `NavigationRouter` for consistent navigation
- **NavigationCoordinator**: Manages navigation state across the app
- **Deep Linking Support**: Structured navigation with proper state management
- **Scroll-based Navigation**: Dynamic navigation titles based on scroll position

### 📊 Data Management
- **Mock Data System**: Comprehensive mock data for development and testing
- **Runtime Data Switching**: Toggle between mock and real data sources
- **User Management**: Full user list with detailed views
- **Settings Persistence**: User preferences and app settings

### 🎪 Example Features
- **User List & Details**: Comprehensive user management with sectioned detail views
- **Counter Example**: Simple state management demonstration
- **Settings Screen**: App configuration and theme switching
- **Dynamic Sections**: Flexible detail view sections (contact, info, social, etc.)

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0+
- iOS 16.0+
- Swift 5.0+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/swift-clean-architecture-mvvm.git
   cd swift-clean-architecture-mvvm
   ```

2. **Generate Xcode project**
   ```bash
   ./generate_project.sh
   ```

3. **Open in Xcode**
   ```bash
   open MySwiftUIApp.xcodeproj
   ```

4. **Build and run**
   - Select your target device/simulator
   - Press ⌘+R to build and run

### Project Generation
This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) for project file generation:

```bash
# Regenerate project structure
./generate_project.sh

# Force regeneration without confirmation
./generate_project.sh --force

# Generate and build
./generate_project.sh --build
```

## 📱 App Structure

### Navigation Flow
```
TabView
├── Home
│   ├── Feature Cards
│   └── Quick Actions
├── Users
│   ├── User List
│   └── User Details
│       ├── Contact Section
│       ├── Info Section
│       ├── Social Section
│       └── Expandable Sections
├── Counter
│   ├── Increment/Decrement
│   └── State Management Demo
└── Settings
    ├── Theme Selection
    ├── Data Source Toggle
    └── App Preferences
```

### Key Components

#### ViewModels
- `UserListViewModel`: Manages user list state and operations
- `UserDetailViewModel`: Handles user detail sections and data
- `CounterViewModel`: Simple counter state management
- `SettingsViewModel`: App settings and preferences

#### Views
- `HomeView`: Main dashboard with feature cards
- `UserListView`: List of users with search and filtering
- `UserDetailView`: Detailed user information with sections
- `CounterView`: Interactive counter demonstration
- `SettingsView`: App configuration screen

#### Core Services
- `NavigationRouter`: Centralized navigation management
- `ThemeManager`: Dark/light mode theme handling
- `DIContainer`: Dependency injection container
- `MockDataManager`: Mock data generation and management

## 🎨 Theming & Customization

### Dark Mode Support
```swift
// ThemeManager handles system-wide theming
@StateObject private var themeManager = ThemeManager.shared

// Custom theme colors
struct ThemeColors {
    static let primary = Color.blue
    static let secondary = Color.gray
    static let background = Color(.systemBackground)
    static let surface = Color(.secondarySystemBackground)
}
```

### Custom Components
- `FeatureCard`: Reusable card component for features
- `UserRowView`: User list item with avatar and info
- `DetailSectionView`: Flexible section component for detail views
- `LoadingView`: Consistent loading state indicator

## 🔧 Configuration

### Environment Setup
The app supports different configurations:

```swift
// DIContainer configuration
extension DIContainer {
    static func configure(useMockData: Bool = true) -> DIContainer {
        // Configure dependencies based on environment
    }
}
```

### Mock Data
Enable/disable mock data in `DIContainer`:

```swift
// Use mock data for development
let container = DIContainer.configure(useMockData: true)

// Use real data sources
let container = DIContainer.configure(useMockData: false)
```

## 📁 Project Structure

```
MySwiftUIApp/
├── App/
│   ├── MySwiftUIApp.swift          # App entry point
│   ├── ContentView.swift           # Root view
│   └── DIContainer.swift           # Dependency injection
├── Core/
│   ├── Navigation/
│   │   ├── NavigationRouter.swift
│   │   └── NavigationCoordinator.swift
│   ├── Network/
│   │   ├── NetworkService.swift
│   │   └── NetworkError.swift
│   ├── Storage/
│   │   └── StorageService.swift
│   └── Utils/
│       ├── ThemeManager.swift
│       ├── ThemeColors.swift
│       └── Constants.swift
├── Data/
│   ├── Models/
│   │   └── UserDTO.swift
│   ├── Network/
│   │   └── UserApiService.swift
│   ├── Repositories/
│   │   ├── UserRepository.swift
│   │   ├── CounterRepository.swift
│   │   └── SettingsRepository.swift
│   └── Mock/
│       ├── UserMockData.swift
│       ├── UserRepositoryMock.swift
│       └── MockDataManager.swift
├── Domain/
│   ├── Entities/
│   │   ├── User.swift
│   │   ├── Counter.swift
│   │   ├── AppSettings.swift
│   │   └── TestModel.swift
│   ├── Repositories/
│   │   └── Repositories.swift
│   └── UseCases/
│       ├── FetchUsersUseCase.swift
│       ├── CounterUseCase.swift
│       └── SettingsUseCase.swift
├── Presentation/
│   ├── Home/
│   │   ├── Views/
│   │   │   └── HomeView.swift
│   │   └── Components/
│   │       └── FeatureCard.swift
│   ├── UserList/
│   │   ├── Views/
│   │   │   ├── UserListView.swift
│   │   │   └── UserDetailView.swift
│   │   ├── ViewModels/
│   │   │   ├── UserListViewModel.swift
│   │   │   ├── UserDetailViewModel.swift
│   │   │   └── UserRowViewModel.swift
│   │   └── Components/
│   │       ├── UserRowView.swift
│   │       ├── DetailSectionView.swift
│   │       └── LoadingView.swift
│   ├── Counter/
│   │   ├── Views/
│   │   │   └── CounterView.swift
│   │   └── ViewModels/
│   │       └── CounterViewModel.swift
│   └── Settings/
│       ├── Views/
│       │   └── SettingsView.swift
│       └── ViewModels/
│           └── SettingsViewModel.swift
└── Assets.xcassets/
    ├── AppIcon.appiconset/
    ├── AccentColor.colorset/
    └── Contents.json
```

## 🛠️ Build & Test

### Available Tasks
```bash
# Build the project
swift build

# Run tests
swift test

# Clean build artifacts
swift package clean

# Open in Xcode
open MySwiftUIApp.xcodeproj
```

### VS Code Tasks
The project includes pre-configured VS Code tasks:
- `Build iOS Project`: Builds the project using Swift Package Manager
- `Test iOS Project`: Runs unit tests
- `Clean Build`: Cleans build artifacts
- `Open Xcode Project`: Opens the project in Xcode

## 🎯 Key Patterns & Practices

### MVVM Implementation
```swift
// ViewModel example
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    
    private let fetchUsersUseCase: FetchUsersUseCase
    
    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    func loadUsers() async {
        // Business logic implementation
    }
}
```

### Dependency Injection
```swift
// DI Container setup
class DIContainer: ObservableObject {
    lazy var userRepository: UserRepositoryProtocol = {
        useMockData ? UserRepositoryMock() : UserRepository()
    }()
    
    lazy var fetchUsersUseCase: FetchUsersUseCase = {
        FetchUsersUseCase(userRepository: userRepository)
    }()
}
```

### Navigation Pattern
```swift
// Centralized navigation
class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to destination: NavigationDestination) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
}
```

## 🔄 State Management

### Data Flow
1. **View** triggers action → **ViewModel**
2. **ViewModel** calls → **Use Case**
3. **Use Case** calls → **Repository**
4. **Repository** fetches from → **Data Source**
5. **Data** flows back through the chain
6. **ViewModel** updates → **@Published** properties
7. **View** automatically updates via **@StateObject**/@ObservedObject

### Mock Data Integration
```swift
// Runtime data source switching
@AppStorage("useMockData") private var useMockData = true

// In DIContainer
lazy var userRepository: UserRepositoryProtocol = {
    useMockData ? UserRepositoryMock() : UserRepository()
}()
```

## 🎨 UI Components

### Reusable Components
- **FeatureCard**: Consistent card layout for features
- **UserRowView**: User list item with avatar and details
- **DetailSectionView**: Flexible section layout for detail screens
- **LoadingView**: Standardized loading indicator

### Custom View Modifiers
- **Theme-aware styling**: Automatic dark/light mode adaptation
- **Responsive layouts**: Adaptive UI for different screen sizes
- **Accessibility support**: VoiceOver and Dynamic Type compatibility

## 🚀 Future Enhancements

### Planned Features
- [ ] Core Data integration
- [ ] Network layer improvements
- [ ] Unit test coverage expansion
- [ ] UI test automation
- [ ] Accessibility improvements
- [ ] Performance optimizations
- [ ] Localization support
- [ ] Widget extensions

### Architecture Improvements
- [ ] Combine framework integration
- [ ] Async/await throughout
- [ ] Error handling refinement
- [ ] Logging and analytics
- [ ] Security enhancements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- Clean Architecture principles by Robert C. Martin
- SwiftUI community and documentation
- XcodeGen for project generation
- Swift Package Manager ecosystem
