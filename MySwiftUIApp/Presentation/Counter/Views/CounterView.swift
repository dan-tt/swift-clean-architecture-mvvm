import SwiftUI

struct CounterView: View {
    @StateObject private var viewModel: CounterViewModel
    
    init(viewModel: CounterViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Counter: \(viewModel.counter.value)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(spacing: 20) {
                    Button("Decrease") {
                        viewModel.decrement()
                    }
                    .themeButton(style: .destructive)
                    
                    Button("Increase") {
                        viewModel.increment()
                    }
                    .themeButton(style: .primary)
                }
                
                Button("Reset") {
                    viewModel.reset()
                }
                .themeButton(style: .secondary)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(Color.theme.error)
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Counter")
            .padding()
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let storageService = UserDefaultsStorageService()
        let repository = CounterRepository(storageService: storageService)
        let useCase = CounterUseCase(repository: repository)
        let viewModel = CounterViewModel(counterUseCase: useCase)
        
        CounterView(viewModel: viewModel)
    }
}
