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
    let artworkUrl512: String
    let trackCensoredName: String
    let averageUserRating: Double
    let artistName: String
    let genres: [String]
    let version: String
    let releaseNotes: String?
    let screenshotUrls: [String]
    let description: String
}
