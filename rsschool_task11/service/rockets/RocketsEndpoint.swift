//
//  RocketApi.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/10/21.
//

import Foundation

public enum RocketsEndpoint {
    case all
    case one(id: String)
}

extension RocketsEndpoint: EndpointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.spacexdata.com/v4/") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .all:
            return "rockets"
        case .one(let id):
            return "rockets/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .all:
            return .request
        case .one(let id):
            return .requestParameters(urlParameters: ["id": id])
        }
        
    }
}

