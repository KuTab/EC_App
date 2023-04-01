import Foundation

struct ActivityResponse: Codable, Hashable {
    var id: Int?
    var answer: String?
    var userEmail: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case answer
        case userEmail = "user_email"
    }
}

var testActivityResponse = ActivityResponse(id: 0, answer: "Answer", userEmail: "email@example.com")
