// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aboutAlbumDataModel = try? newJSONDecoder().decode(AboutAlbumDataModel.self, from: jsonData)

import Foundation

// MARK: - AboutAlbumDataModel
struct DetailAlbumDataModel: Codable {
    let results: [Results]
}

// MARK: - Result
struct Results: Codable {
    let wrapperType: WrapperType
    let releaseDate: String?
    let trackName: String?
}

enum WrapperType: String, Codable {
    case collection = "collection"
    case track = "track"
}

