import Foundation

final class RequestParser {
    
    class func parsingURLRequest<T>(to type: T.Type, from data: Data) -> T? where T : Decodable  {
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(type, from: data) else { return nil }
        return result
    }
    
}
