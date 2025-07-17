import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    // MARK: - Configuration
    private var isUsingMockData: Bool {
        return Self.effectiveConfiguration.isUsingMockData
    }
    
    private init() {}
    
    // MARK: - Core Services
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    lazy var storageService: StorageServiceProtocol = UserDefaultsStorageService()
    
    // MARK: - Data Layer
    lazy var userApiService: UserApiService = UserApiService(networkService: networkService)
    
    // MARK: - Repositories
    lazy var userRepository: UserRepositoryProtocol = UserRepository(apiService: userApiService)
    lazy var userRepositoryMock: UserRepositoryProtocol = UserRepositoryMock()
    lazy var counterRepository: CounterRepositoryProtocol = CounterRepository(storageService: storageService)
    lazy var settingsRepository: SettingsRepositoryProtocol = SettingsRepository(storageService: storageService)
    
    // MARK: - Use Cases
    lazy var fetchUsersUseCase: FetchUsersUseCaseProtocol = {
        if isUsingMockData {
            return FetchUsersUseCase(repository: userRepositoryMock)
        } else {
            return FetchUsersUseCase(repository: userRepository)
        }
    }()
    
    lazy var counterUseCase: CounterUseCaseProtocol = CounterUseCase(repository: counterRepository)
    lazy var settingsUseCase: SettingsUseCaseProtocol = SettingsUseCase(repository: settingsRepository)
    
    // MARK: - Theme Manager
    @MainActor
    lazy var themeManager: ThemeManager = ThemeManager(settingsUseCase: settingsUseCase)
    
    // MARK: - ViewModels
    @MainActor
    func makeUserListViewModel() -> UserListViewModel {
        return UserListViewModel(fetchUsersUseCase: fetchUsersUseCase)
    }
    
    @MainActor
    func makeCounterViewModel() -> CounterViewModel {
        return CounterViewModel(counterUseCase: counterUseCase)
    }
    
    @MainActor
    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(settingsUseCase: settingsUseCase)
    }
    
    // MARK: - Configuration Methods
    func setMockDataEnabled(_ enabled: Bool) {
        // Note: This would require reinitializing the use case
        // For now, change the isUsingMockData property and restart the app
        print("Mock data mode: \(enabled ? "ENABLED" : "DISABLED")")
        print("⚠️ Restart the app to apply changes")
    }
    
    func isMockDataEnabled() -> Bool {
        return isUsingMockData
    }
    
    // MARK: - Factory Methods for Testing
    func makeFetchUsersUseCaseMock() -> FetchUsersUseCaseProtocol {
        return FetchUsersUseCase(repository: userRepositoryMock)
    }
    
    func makeFetchUsersUseCaseReal() -> FetchUsersUseCaseProtocol {
        return FetchUsersUseCase(repository: userRepository)
    }
}
