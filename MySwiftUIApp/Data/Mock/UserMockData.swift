import Foundation

struct UserMockData {
    
    static let jsonString = """
    [
        {
            "id": 1,
            "name": "John Doe",
            "email": "john.doe@example.com",
            "phone": "+1 (555) 123-4567",
            "website": "johndoe.com",
            "company": {
                "name": "Tech Solutions Inc.",
                "catchPhrase": "Innovation at its finest",
                "bs": "revolutionize cutting-edge technologies"
            }
        },
        {
            "id": 2,
            "name": "Jane Smith",
            "email": "jane.smith@example.com",
            "phone": "+1 (555) 987-6543",
            "website": "janesmith.dev",
            "company": {
                "name": "Creative Studios",
                "catchPhrase": "Design thinking reimagined",
                "bs": "streamline intuitive experiences"
            }
        },
        {
            "id": 3,
            "name": "Mike Johnson",
            "email": "mike.johnson@example.com",
            "phone": "+1 (555) 456-7890",
            "website": "mikejohnson.io",
            "company": {
                "name": "Digital Dynamics",
                "catchPhrase": "Transforming digital landscapes",
                "bs": "optimize scalable solutions"
            }
        },
        {
            "id": 4,
            "name": "Sarah Wilson",
            "email": "sarah.wilson@example.com",
            "phone": "+1 (555) 321-0987",
            "website": "sarahwilson.net",
            "company": {
                "name": "Data Analytics Co.",
                "catchPhrase": "Data-driven decisions",
                "bs": "harness actionable insights"
            }
        },
        {
            "id": 5,
            "name": "David Brown",
            "email": "david.brown@example.com",
            "phone": "+1 (555) 654-3210",
            "website": "davidbrown.tech",
            "company": {
                "name": "Cloud Systems Ltd.",
                "catchPhrase": "Sky-high performance",
                "bs": "leverage cloud-native architectures"
            }
        },
        {
            "id": 6,
            "name": "Emily Davis",
            "email": "emily.davis@example.com",
            "phone": "+1 (555) 789-0123",
            "website": "emilydavis.design",
            "company": {
                "name": "UX Innovations",
                "catchPhrase": "User-centered excellence",
                "bs": "enhance user engagement paradigms"
            }
        },
        {
            "id": 7,
            "name": "Alex Chen",
            "email": "alex.chen@example.com",
            "phone": "+1 (555) 246-8135",
            "website": "alexchen.ai",
            "company": {
                "name": "AI Research Labs",
                "catchPhrase": "Artificial intelligence, real results",
                "bs": "democratize machine learning workflows"
            }
        },
        {
            "id": 8,
            "name": "Lisa Rodriguez",
            "email": "lisa.rodriguez@example.com",
            "phone": "+1 (555) 135-7924",
            "website": "lisarodriguez.consulting",
            "company": {
                "name": "Strategic Consulting Group",
                "catchPhrase": "Strategic thinking, tactical execution",
                "bs": "synthesize holistic methodologies"
            }
        },
        {
            "id": 9,
            "name": "Robert Kim",
            "email": "robert.kim@example.com",
            "phone": "+1 (555) 864-2907",
            "website": "robertkim.blockchain",
            "company": {
                "name": "Blockchain Ventures",
                "catchPhrase": "Decentralized future solutions",
                "bs": "tokenize distributed ecosystems"
            }
        },
        {
            "id": 10,
            "name": "Maria Garcia",
            "email": "maria.garcia@example.com",
            "phone": "+1 (555) 573-1946",
            "website": "mariagarcia.sustainability",
            "company": {
                "name": "Green Tech Solutions",
                "catchPhrase": "Sustainable innovation for tomorrow",
                "bs": "optimize eco-friendly paradigms"
            }
        },
        {
            "id": 11,
            "name": "James Wilson",
            "email": "james.wilson@example.com",
            "phone": "+1 (555) 741-8520",
            "website": "jameswilson.fintech",
            "company": {
                "name": "FinTech Innovations",
                "catchPhrase": "Financial technology redefined",
                "bs": "revolutionize digital payment ecosystems"
            }
        },
        {
            "id": 12,
            "name": "Anna Thompson",
            "email": "anna.thompson@example.com",
            "phone": "+1 (555) 963-2580",
            "website": "annathompson.health",
            "company": {
                "name": "HealthTech Solutions",
                "catchPhrase": "Healthcare innovation for everyone",
                "bs": "optimize patient-centric care models"
            }
        }
    ]
    """
    
    static func getUsers() -> [UserEntity] {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("❌ Failed to convert JSON string to data")
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([UserEntity].self, from: jsonData)
        } catch {
            print("❌ Error decoding user mock data: \(error)")
            return []
        }
    }
    
    static func getUser(by id: Int) -> UserEntity? {
        return getUsers().first { $0.id == id }
    }
    
    static func getRandomUsers(count: Int = 5) -> [UserEntity] {
        let allUsers = getUsers()
        return Array(allUsers.shuffled().prefix(count))
    }
}
