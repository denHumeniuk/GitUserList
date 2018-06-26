import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

final class APIService {
    
    private init() {}
    static let shared = APIService()
    
    private let session = URLSession(configuration: .default)
    
    private func dataTaskWithParser<T>(with request: URLRequest, parsType: T.Type, completionHandler: ((Result<T?>) -> Void)?) where T: Decodable {
        session.dataTask(with: request){ (responseData, response, responseError) in
            guard responseError == nil else {
                completionHandler?(.failure(responseError!))
                return
            }
            guard let jsonData = responseData, let result = RequestParser.parsingURLRequest(to: parsType, from: jsonData) else {
                completionHandler?(.success(nil))
                return
            }
            completionHandler?(.success(result))
        }.resume()
    }
}

extension APIService {
    
    public func getUsers(since: Int, per_page: Int = 30, completionHandler: @escaping ((Result<[User]?>) -> Void)){
        
        let params: [URLQueryItem] = [ URLQueryItem(name: "since", value: String(since)), URLQueryItem(name: "per_page", value: "\(per_page)")]
        guard let request = ProjectRequests.getUsers.getRequest(params: params) else { return }
        dataTaskWithParser(with: request, parsType: [User].self, completionHandler: completionHandler)
    }
    
    public func getListFollowers(of user: String, page: Int, per_page: Int = 30, completionHandler: @escaping ((Result<[Follower]?>) -> Void)){
        let params: [URLQueryItem] = [ URLQueryItem(name: "page", value: String(page)), URLQueryItem(name: "per_page", value: "\(per_page)")]
        guard let request = ProjectRequests.getFollowers.getRequest(params: params, with: user) else { return }
        dataTaskWithParser(with: request, parsType: [Follower].self, completionHandler: completionHandler)
    }
}
