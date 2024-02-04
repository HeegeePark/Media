//
//  TVAPI.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import Foundation
import Alamofire

class TVAPI {
    static let shared = TVAPI()
    
    private init() { }
    
    func request<T: Decodable>(router: APIRouter, model: T.Type, _ completionHandler: @escaping (T) -> Void) {
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
}
