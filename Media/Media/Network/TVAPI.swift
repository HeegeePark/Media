//
//  TVAPI.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import Foundation
import Alamofire

enum CustomError: Error {
    case failedRequest
    case noData
    case invalidPath
    case invalidResponse
    case invalidData
    case failedDecoding
}

class TVAPI {
    static let shared = TVAPI()
    
    private init() { }
    
    func requestByAF<T: Decodable>(router: APIRouter, model: T.Type, _ completionHandler: @escaping (T) -> Void) {
        AF.request(router.endpoint, method: router.method, parameters: router.parameters, encoding: router.urlEncoding, headers: router.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                
                completionHandler(success)
            case .failure(let failure):
                print(#function, "fail: ", failure)
            }
        }
    }
    
    func request<T: Decodable>(router: APIRouter, model: T.Type, _ completionHandler: @escaping (Result<T, CustomError>) -> Void) {
        
        URLSession.shared.dataTask(with: router.request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("network fail")
                    completionHandler(.failure(.failedRequest))
                    return
                }
                
                guard let data else {
                    print("data nil")
                    completionHandler(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("network success but response is nil")
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("network success but statusCode is invalid")
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(.failedDecoding))
                }
            }
            
        }.resume()
    }
}
