import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol EndpointProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var header: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    func request() -> URLRequest
}

extension EndpointProtocol {
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseUrl + path) else {
            fatalError("Invalid URL")
        }
        
        // queryItems'i kullanmadan direkt query'i eklemek
        let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: Endpoint.apiKey)
        components.queryItems = [apiKeyQueryItem]
        
        // Diğer query parametrelerini eklemek için
        if let queryItems = queryItems {
            components.queryItems?.append(contentsOf: queryItems)
        }
      
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = header {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}

enum Endpoint: EndpointProtocol {
    
    static let apiKey = "24b29964c70d4676b0c7d4d056402af9"
    
    case getTopHeadlines(country: String)
    case getEverything(query: String?)
    case search(query: String)
    
    var baseUrl: String {
        return "https://newsapi.org/v2/"
    }
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "top-headlines"
        case .getEverything:
            return "everything"
        case .search(_):
            return "everything"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var header: [String: String]? {
        return ["Authorization": "Bearer \(Endpoint.apiKey)"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getEverything(let query):
            var items: [URLQueryItem] = []
            if let query = query {
                items.append(URLQueryItem(name: "q", value: query))
            }
            return items
        case .getTopHeadlines(let country):
            return [URLQueryItem(name: "country", value: country)]
            
        case .search(let query):
            return [URLQueryItem(name: "q", value: query)]
     
        }
    }
}
