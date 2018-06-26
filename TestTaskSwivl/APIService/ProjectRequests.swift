import Foundation

enum ProjectRequests {
    case getUsers, getFollowers
    
    public func getRequest(params: [URLQueryItem]? = nil, with variableURLArgument: String? = nil) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.urlScheme
        urlComponents.host = self.urlHostPart
        urlComponents.path = self.getURLPath(with: variableURLArgument)
        urlComponents.queryItems = params
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.getHttpMethod()
        return request
    }
}

extension ProjectRequests { // Configuration request
    
    private var urlScheme : String {
        return "https"
    }
    
    private var urlHostPart : String {
        return "api.github.com"
    }
    
    private func getURLPath(with variableURLArgument: String? = nil) -> String {
        switch self {
        case .getUsers:
            return "/users"
        case .getFollowers:
            return "/users" + (variableURLArgument == nil ? "" : "/\(variableURLArgument!)") + "/followers"
        }
    }
    
    private func getHttpMethod() -> String{
        switch self {
        case .getUsers, .getFollowers:
            return "GET"
        }
    }
}

