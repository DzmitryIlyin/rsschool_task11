//
//  RocketClient.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/11/21.
//

import Foundation

typealias RocketCompactClosure = (Result<[RocketCompactCard], APIError>) -> Void
typealias RocketDetailsClosure = (Result<RocketCard, APIError>) -> Void

class RocketClient {
    
    let service = SpaceXService()
    
    func getRockets(completion: @escaping RocketCompactClosure) {
        service.loadDataArray(service: RocketsEndpoint.all) { (result: Result<[RocketCompactCard], APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRocket(id: String, completion: @escaping RocketDetailsClosure) {
        service.loadData(service: RocketsEndpoint.one(id: id)) { (result: Result<RocketCard, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

}
