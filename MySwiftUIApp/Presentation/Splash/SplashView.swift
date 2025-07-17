import SwiftUI

struct SplashView: View {
    @State private var isLoading = true
    @State private var opacity = 0.0
    @State private var scale = 0.8
    
    let onSplashComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Background color with gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.accentColor,
                    Color.accentColor.opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App icon or logo placeholder with animation
                Image(systemName: "app.fill")
                    .font(.system(size: 100, weight: .light))
                    .foregroundColor(.white)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .animation(.easeInOut(duration: 1.0), value: scale)
                    .animation(.easeInOut(duration: 1.0), value: opacity)
                
                // App name with fade in animation
                Text("MySwiftUIApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .animation(.easeInOut(duration: 1.0).delay(0.3), value: opacity)
                
                // Loading indicator with delay
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.2)
                        .tint(.white)
                        .opacity(opacity)
                        .animation(.easeInOut(duration: 1.0).delay(0.6), value: opacity)
                }
            }
        }
        .onAppear {
            // Start animations
            withAnimation {
                opacity = 1.0
                scale = 1.0
            }
            
            // Complete splash after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isLoading = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    onSplashComplete()
                }
            }
        }
    }
}

#Preview {
    SplashView(onSplashComplete: {})
}
