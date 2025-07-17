import SwiftUI

struct UserRowView: View {
    let viewModel: UserRowViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // User Avatar
            Circle()
                .fill(viewModel.backgroundColor)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(viewModel.initials)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                )
            
            // User Information
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.displayName)
                    .font(.headline)
                    .foregroundColor(Color.theme.primaryText)
                
                Text(viewModel.displayEmail)
                    .font(.subheadline)
                    .foregroundColor(Color.theme.secondaryText)
                
                Text(viewModel.displayCompanyInfo)
                    .font(.caption)
                    .foregroundColor(Color.theme.info)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Chevron indicator
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.theme.tertiaryText)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = UserEntity(
            id: 1,
            name: "John Doe",
            email: "john@example.com",
            phone: "123-456-7890",
            website: "johndoe.com",
            company: UserEntity.Company(
                name: "Acme Corp",
                catchPhrase: "Innovation at its best",
                bs: "synergistic solutions"
            )
        )
        
        VStack(spacing: 8) {
            UserRowView(viewModel: UserRowViewModel.from(sampleUser))
            
            Divider()
            
            UserRowView(viewModel: UserRowViewModel(from: UserEntity(
                id: 2,
                name: "Jane Smith",
                email: "jane.smith@example.com",
                phone: "987-654-3210",
                website: "janesmith.dev",
                company: UserEntity.Company(
                    name: "Tech Solutions",
                    catchPhrase: "Building the future",
                    bs: "innovative platforms"
                )
            )))
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
