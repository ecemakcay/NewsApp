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
    
    static let apiKey = "40b218b9431740f59b200eb5dd1fdb3d"
    
    case getTopHeadlines(sources: String)
    case getEverything(query: String?)
    
    var baseUrl: String {
        return "https://newsapi.org/v2/"
    }
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "top-headlines"
        case .getEverything:
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
        case .getTopHeadlines(let sources):
            return [URLQueryItem(name: "sources", value: sources)]
     
        }
    }
}
