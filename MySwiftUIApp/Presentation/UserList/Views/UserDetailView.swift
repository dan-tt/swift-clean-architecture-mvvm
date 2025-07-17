import SwiftUI

struct UserDetailView: View {
    @StateObject private var viewModel: UserDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showNavigationTitle = false
    
    init(user: UserEntity) {
        self._viewModel = StateObject(wrappedValue: UserDetailViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 24) {
                        // Header Section with scroll tracking
                        HeaderView(
                            displayName: viewModel.displayName,
                            initials: viewModel.initials,
                            backgroundColor: viewModel.backgroundColor
                        )
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetPreferenceKey.self,
                                        value: geometry.frame(in: .named("scroll")).minY
                                    )
                            }
                        )
                    
                    // Contact Information
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Contact Information")
                        
                        ContactRow(
                            icon: "envelope.fill",
                            title: "Email",
                            value: viewModel.displayEmail,
                            action: { viewModel.sendEmail() }
                        )
                        
                        ContactRow(
                            icon: "phone.fill",
                            title: "Phone",
                            value: viewModel.displayPhone,
                            action: { viewModel.callPhone() }
                        )
                        
                        ContactRow(
                            icon: "globe",
                            title: "Website",
                            value: viewModel.displayWebsite,
                            action: { viewModel.openWebsite() }
                        )
                    }
                    .padding(.horizontal)
                    
                    // Company Information
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Company")
                        
                        VStack(alignment: .leading, spacing: 12) {
                            InfoRow(title: "Company Name", value: viewModel.displayCompanyName)
                            InfoRow(title: "Catch Phrase", value: viewModel.displayCompanyCatchPhrase)
                            InfoRow(title: "Business", value: viewModel.displayCompanyBusiness)
                        }
                        .padding()
                        .background(Color.theme.cardBackground)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                }
            }
            .coordinateSpace(name: "scroll")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationTitle(showNavigationTitle ? viewModel.displayName : "")
            .onAppear {
                // Ensure navigation title is hidden initially
                showNavigationTitle = false
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                // Use a more sensitive threshold for better responsiveness
                let threshold: CGFloat = -50
                let shouldShow = value < threshold
                
                // Only update if the state actually changed to avoid unnecessary animations
                if showNavigationTitle != shouldShow {
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showNavigationTitle = shouldShow
                        }
                    }
                }
                
                // Debug: Print scroll values to help troubleshoot
                print("Scroll value: \(value), threshold: \(threshold), showTitle: \(shouldShow)")
            }
            }
        }
    }
}

// MARK: - Scroll Offset Preference Key
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Supporting Views

struct HeaderView: View {
    let displayName: String
    let initials: String
    let backgroundColor: Color
    
    var body: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(backgroundColor)
                .frame(width: 120, height: 120)
                .overlay(
                    Text(initials)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                )
            
            Text(displayName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.primaryText)
        }
        .padding(.top, 20)
        .id("header")
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Color.theme.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContactRow: View {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(Color.theme.info)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    Text(value)
                        .font(.body)
                        .foregroundColor(Color.theme.primaryText)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Color.theme.tertiaryText)
            }
            .padding()
            .background(Color.theme.cardBackground)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(value)
                .font(.body)
                .foregroundColor(Color.theme.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview
struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = UserEntity(
            id: 1,
            name: "John Doe",
            email: "john.doe@example.com",
            phone: "+1 (555) 123-4567",
            website: "johndoe.com",
            company: UserEntity.Company(
                name: "Tech Solutions Inc.",
                catchPhrase: "Innovation at its finest",
                bs: "revolutionize cutting-edge technologies"
            )
        )
        
        NavigationView {
            UserDetailView(user: sampleUser)
        }
    }
}
