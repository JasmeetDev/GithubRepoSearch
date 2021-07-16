//
//  BaseRequest.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import Foundation

public enum Method: Int {
    case post, get, put, delete
    
    var name: String {
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        case .put:
            return "PUT"
        default:
            return "DELETE"
        }
    }
}

typealias JSONDictionary = [String: Any]

class BaseRequest {
    var url = ""
    var requestType = Method.get
    var parameters: [String: Any]?

    init(url: String) {
        self.url = url
    }

    init(url: String, requestType: Method) {
        self.url = url
        self.requestType = requestType
    }

    init(url: String, requestType: Method, parameters: [String: Any]?) {
        self.url = url
        self.requestType = requestType
        self.parameters = parameters
    }
}

struct ApiConstants {
    static let baseApiPath = "https://api.github.com/"
}
