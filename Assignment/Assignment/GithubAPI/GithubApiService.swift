//
//  GithubApiService.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

enum VDResult <T> {
    case success(T)
    case failure(String)
}

public class GithubApiService: NSObject {
    
    static let shared = GithubApiService()
    
    private override init() {}
    
    func startService<T: Decodable>(baseRequest: BaseRequest,
                                    path: String? = nil,
                                    completion: @escaping (VDResult<T>) -> Void) {
        
        guard let url = URL(string: baseRequest.url) else {
            return completion(.failure("Invalid URL, we can't proceed."))
        }
        apiCall(baseRequest: baseRequest,
                url: url,
                parameters: baseRequest.parameters,
                completion: completion)
    }
    
    private func apiCall<T: Decodable>(baseRequest: BaseRequest,
                                       url: URL,
                                       parameters: [String: Any]?,
                                       completion: @escaping (VDResult<T>) -> Void) {
        debugPrint("API Request parameters: \(String(describing: baseRequest.parameters))")
        let request = self.buildRequest(with: baseRequest.requestType,
                                        url: url,
                                        parameters: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return completion(.failure(error!.localizedDescription)) }
            guard let data = data else { return completion(.failure(error!.localizedDescription)) }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let error {
                debugPrint(error)
                return completion(.failure(error.localizedDescription))
            }
        }
        task.resume()
        
    }
}

extension GithubApiService {
    
    func buildRequest(with method: Method,
                      url: URL,
                      parameters: [String: Any]?) -> URLRequest {
        var request: URLRequest?
        switch method {
        
        case .get:
            if let params = parameters, !params.isEmpty {
                let urlString = url.absoluteString.appending("?" + buildParams(parameters: params))
                if let queryUrl = URL(string: urlString) {
                    request = URLRequest(url: queryUrl)
                    request?.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                }
            }
            
        case .post:
            request = URLRequest(url: url)
            if let params = parameters, !params.isEmpty {
                request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
                let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request?.httpBody = jsonData
            }
            
        case .put:
            request = URLRequest(url: url)
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let  jsonData = try? JSONSerialization.data(withJSONObject: parameters ?? [String: Any](),
                                                        options: .prettyPrinted)
            request?.httpBody = jsonData
            
        default:
            request = URLRequest(url: url)
        }
        
        var req = request ?? URLRequest(url: url)
        debugPrint(req)
        req.httpMethod = method.name
        return req
    }
    
    private func buildParams(parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        for (key, value) in parameters {
            components += self.queryComponents(key, value)
        }
        return (components.map {"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    
    func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
        }
        
        return components
    }
    
    func escape(string: String) -> String {
        if let encodedString = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            return encodedString
        }
        return ""
    }
}
