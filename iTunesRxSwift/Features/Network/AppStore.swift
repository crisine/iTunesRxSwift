//
//  AppStore.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/7/24.
//

import Foundation

// MARK: - AppStore
struct AppStore: Decodable {
    let resultCount: Int
    let results: [App]
}

// MARK: - Result
struct App: Decodable {
    let trackCensoredName: String
}