// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albumDataModel = try? newJSONDecoder().decode(AlbumDataModel.self, from: jsonData)

import Foundation

// MARK: - AlbumDataModel
struct AlbumDataModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let collectionID: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int

    enum CodingKeys: String, CodingKey {
        case collectionID = "collectionId"
        case artistName
        case collectionName
        case artworkUrl100
        case trackCount
    }
}

