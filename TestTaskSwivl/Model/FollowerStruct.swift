import Foundation

struct Follower: Codable {
    let login: String
    let id: Int
    let avatarLink: String
    
    enum CodingKeys:String,CodingKey {
        case login
        case avatarLink = "avatar_url"
        case id
    }
}
