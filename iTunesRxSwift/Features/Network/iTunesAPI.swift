//
//  iTunesAPI.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import Foundation
import Alamofire

protocol APIProtocol {
    var endpoint: URL { get }
    var method : HTTPMethod { get }
    var parameter : Parameters { get }
}

enum iTunesAPI: APIProtocol {
    
    case search(query: String)
    
    var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search?")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .search(let query):
            ["term": query, "entity": "software", "country": "kr"]
        }
    }
    
}

