//
//  Song.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/06.
//

import Foundation

// MARK: - SongResult
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Result
struct Song: Codable, Identifiable {
    let wrapperType, kind: String
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName: String
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    let releaseDate: String
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName: String
    let isStreamable: Bool
    
    var id: Int {
        return trackID
    }

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
    
    static func example() -> Song {
        return Song(
            wrapperType: "track",
            kind: "song",
            artistID: 909253,
            collectionID: 1469577723,
            trackID: 1469577741,
            artistName: "Jack Johnson",
            collectionName: "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
            trackName: "Upside Down",
            collectionCensoredName: "",
            trackCensoredName: "",
            artistViewURL: "https://music.apple.com/us/artist/jack-johnson/909253?uo=4",
            collectionViewURL: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
            trackViewURL: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
            previewURL: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/5e/5b/3d/5e5b3df4-deb5-da78-5d64-fe51d8404d5c/mzaf_13341178261601361485.plus.aac.p.m4a",
            artworkUrl30: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/30x30bb.jpg",
            artworkUrl60: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/60x60bb.jpg",
            artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg",
            collectionPrice: 9.99,
            trackPrice: 1.29,
            releaseDate: "2005-01-01T12:00:00Z",
            collectionExplicitness: "notExplicit",
            trackExplicitness: "notExplicit",
            discCount: 1,
            discNumber: 1,
            trackCount: 14,
            trackNumber: 1,
            trackTimeMillis: 208643,
            country: "USA",
            currency: "USD",
            primaryGenreName: "Rock",
            isStreamable: true
        )
    }
}
