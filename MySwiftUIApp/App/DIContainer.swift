import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Core Services
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    lazy var storageService: StorageServiceProtocol = UserDefaultsStorageService()
    
    // MARK: - Data Layer
    lazy var userApiService: UserApiService = UserApiService(networkService: networkService)
    
    // MARK: - Repositories
    lazy var userRepository: UserRepositoryProtocol = UserRepository(apiService: userApiService)
    lazy var counterRepository: CounterRepositoryProtocol = CounterRepository(storageService: storageService)
    lazy var settingsRepository: SettingsRepositoryProtocol = SettingsRepository(storageService: storageService)
    
    // MARK: - Use Cases
    lazy var fetchUsersUseCase: FetchUsersUseCaseProtocol = FetchUsersUseCase(repository: userRepository)
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
}
