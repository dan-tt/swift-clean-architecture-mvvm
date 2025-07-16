import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Image(systemName: "swift")
                        .font(.system(size: 100))
                        .foregroundColor(Color.theme.primary)
                    
                    Text("Welcome to MySwiftUIApp!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.theme.primaryText)
                    
                    Text("A modern iOS app built with SwiftUI using Clean Architecture and MVVM pattern")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        FeatureCard(
                            icon: "swift",
                            title: "Swift Package Manager",
                            description: "Easy dependency management"
                        )
                        
                        FeatureCard(
                            icon: "paintbrush",
                            title: "SwiftUI",
                            description: "Modern declarative UI framework"
                        )
                        
                        FeatureCard(
                            icon: "building.2",
                            title: "Clean Architecture",
                            description: "Separation of concerns with MVVM"
                        )
                        
                        FeatureCard(
                            icon: "iphone",
                            title: "iOS 16+",
                            description: "Built for modern iOS versions"
                        )
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
