import SwiftUI

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.theme.primaryText)
                
                Text(description)
                    .font(.subheadline)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color.theme.secondaryText)
            }
            
            Spacer()
        }
        .padding()
        .themeCard()
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(
            icon: "swift",
            title: "Swift Package Manager",
            description: "Easy dependency management"
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
