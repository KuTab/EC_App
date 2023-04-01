import Foundation

struct User: Codable, Hashable {
    
    var firstName: String
    
    var lastName: String
    
    var username: String
    
    var email: String
    
    var password: String?
    
    var isAdmin: Bool?
    
    var points: Int?
    
    var mediaLink: String?
    
    var registeredAt: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case email
        case password
        case isAdmin = "is_admin"
        case points
        case mediaLink = "media_link"
        case registeredAt = "registered_at"
    }
    
    init(firstName: String, lastName: String, username: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
        self.password = password
        self.isAdmin = false
        self.mediaLink = ""
    }
    
    public func toListViewModel() -> ListViewModel {
        return ListViewModel(title: username, subtitle: email, addition: String(points ?? 0))
    }
}

struct RedactedUser: Codable {
    var firstName: String
    var lastName: String
    var username: String
    var mediaLink: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case mediaLink = "media_link"
    }
}
