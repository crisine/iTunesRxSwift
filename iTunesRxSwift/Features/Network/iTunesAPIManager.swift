//
//  iTunesAPIManager.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import Foundation
import Alamofire

final class iTunesAPIManager {
    
    static let shared = iTunesAPIManager()
    
    private init() {}
    
    func request<T: Decodable, API: APIProtocol>(type: T.Type, api: API, completionHandler: @escaping ((T) -> Void)) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets)).responseDecodable(of: type) { response in
            
            print("다음 URL로 요청중: " + String(describing: response.request))
            
            switch response.result {
                
            case .success(let success):
                completionHandler(success)
                
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
