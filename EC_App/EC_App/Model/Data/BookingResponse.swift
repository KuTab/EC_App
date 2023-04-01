import Foundation

struct BookingResponse: Codable, Hashable {
    var id: Int
    var user: User
    var session: Session
    
    enum CodingKeys: String, CodingKey {
        case id
        case user = "user_info"
        case session = "shift_info"
    }
}

