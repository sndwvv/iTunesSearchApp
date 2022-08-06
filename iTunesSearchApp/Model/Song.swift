//
//  Song.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/06.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let songResult = try? newJSONDecoder().decode(SongResult.self, from: jsonData)

// MARK: - SongResult
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Result
struct Song: Codable {
    let wrapperType, kind: String
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double
    let releaseDate: Date
    let collectionExplicitness, trackExplicitness: String
    let discCount, discNumber, trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country, currency, primaryGenreName: String
    let isStreamable: Bool

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
    }
}
