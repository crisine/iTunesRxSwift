//
//  iTunesAPIManager.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import Foundation
import Alamofire
import RxSwift

enum APIError: Error, CustomStringConvertible {
    case invalidURL
    case unknownResponse
    case statusError
    
    var description: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .unknownResponse:
            return "알 수 없는 응답값을 수신했습니다."
        case .statusError:
            return "상태 코드 에러가 발생했습니다."
        }
    }
}

final class iTunesAPIManager {
    
    static let shared = iTunesAPIManager()
    
    private init() {}
    
    func request<T: Decodable, API: APIProtocol>(type: T.Type, api: API)
    -> Single<Result<T, APIError>> {
        
        return Single.create { single -> Disposable in
            
            AF.request(api.endpoint,
                       method: api.method,
                       parameters: api.parameter,
                       encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: type) { response in
                print("다음 URL로 요청중: " + String(describing: response.request))
                
                switch response.result {
                    
                case .success(let success):
                    single(.success(.success(success)))
                    
                case .failure(let failure):
                    single(.success(.failure(APIError.invalidURL)))
                }
            }
            return Disposables.create()
        }
        .debug("Single ResultType Request")
    }
}
