import Foundation

struct Token: Decodable {
    var accessToken: String?
    var tokenType: String?
    var expire: String?
    var userInfo: User?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expire
        case userInfo = "user_info"
    }
}
