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
    
    func getTV(router: APIRouter, _ completionHandler: @escaping (TVResult) -> Void) {
        let url = router.requestURL
        
        AF.request(url, headers: router.headers).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print("fail: ", failure)
            }
        }
    }
}
