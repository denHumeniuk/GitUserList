import Foundation

struct User: Codable {
    let login: String
    let userLink: String
    let avatarLink: String
    let id: Int
    
    enum CodingKeys:String,CodingKey {
        case login
        case userLink = "html_url"
        case avatarLink = "avatar_url"
        case id
    }
}
