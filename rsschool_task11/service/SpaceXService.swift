//
//  SpaceXService.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/11/21.
//

import Foundation

enum APIError: Error {
    case success
    case urlError
    case badRequest
    case failed
    case noData
    case unableToDencode
    case unknownError(description: String)
    var localizedDescription: String {
        switch self {
        case .success: return "Success"
        case .urlError: return "URL error"
        case .badRequest: return "Bad request"
        case .failed: return "Network request failed"
        case .noData: return "Response returned with no data"
        case .unableToDencode: return "Failed to decode response"
        case .unknownError(let description): return description
        }
    }
}

typealias GenericArrayReturnClosure<T> = (Result<[T], APIError>) -> ()
typealias GenericSingleReturnClosure<T> = (Result<T, APIError>) -> ()

class SpaceXService {
    
    private var task: URLSessionTask?
    private var urlSession = URLSession.shared
    
//  MARK: map response data to entity into array
    func loadDataArray<T: Codable>(service: EndpointType, completion: @escaping GenericArrayReturnClosure<T>) {
        call(service: service) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let resp = try decoder.decode([T].self, from: data)
                        completion(.success(resp))
                    } catch {
                        completion(.failure(APIError.unableToDencode))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    //  MARK: map response data to single entity
        func loadData<T: Codable>(service: EndpointType, completion: @escaping GenericSingleReturnClosure<T>) {
            call(service: service) { result in
                    switch result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let resp = try decoder.decode(T.self, from: data)
                            completion(.success(resp))
                        } catch {
                            completion(.failure(APIError.unableToDencode))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    
//    func loadImages() {
//
//    }
    
//    MARK: make the call
    private func call(service: EndpointType, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data, APIError>) -> Void) {
        do {
            let request = try self.buildRequest(service: service)
            
            self.task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let err = error {
                        completion(.failure(.unknownError(description: err.localizedDescription)))
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        let result = self.handleResponseCode(response)
                        
                        switch result {
                        case .success(_):
                            if let data = data {
                                completion(.success(data))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            })
        } catch {
            completion(.failure(.unknownError(description: error.localizedDescription)))
        }
        
        self.task?.resume()
    }
    
    private func handleResponseCode(_ response: HTTPURLResponse) -> Result<String, APIError> {
        switch response.statusCode {
        case 200...299: return .success("success")
        case 501...599: return .failure(APIError.badRequest)
        default: return .failure(APIError.failed)
        }
    }
    
//    MARK: construct request
    private func buildRequest(service: EndpointType) throws -> URLRequest {
        var request = URLRequest(url: service.baseURL.appendingPathComponent(service.path))
        
        request.httpMethod = service.httpMethod.rawValue
        
        do{
            switch service.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
            case .requestParameters(let urlParameters):
               try self.configureParameters(request: &request, urlParameters: urlParameters)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(request: inout URLRequest, urlParameters: [String: Any]) throws {
        do {
            try self.encodeUrl(urlRequest: &request, with: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func encodeUrl(urlRequest: inout URLRequest, with parameters: [String: Any]) throws {
        
        guard let url = urlRequest.url else {
            throw APIError.urlError
        }
         
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        if urlRequest.value(forHTTPHeaderField: "Content-type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        }
    }

}
