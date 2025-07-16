import SwiftUI

struct UserRowView: View {
    let user: UserEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.name)
                .font(.headline)
                .foregroundColor(Color.theme.primaryText)
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
            Text(user.company.name)
                .font(.caption)
                .foregroundColor(Color.theme.info)
        }
        .padding(.vertical, 2)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: UserEntity(
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
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
