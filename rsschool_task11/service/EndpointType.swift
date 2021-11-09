//
//  JSONParser.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/10/21.
//

import Foundation

public typealias HTTPHeaders = [String:String]

protocol EndpointType {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPTask {
    case request
    
    case requestParameters(urlParameters: [String:Any])
}
