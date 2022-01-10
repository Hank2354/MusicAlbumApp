//
//  AboutAlbumModel.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 05.12.2021.
//

import Foundation

struct DetailAlbumModel {
    var collectionName: String
    var artistName: String
    var imageURL: String
    var releaseDate: String
    var tracks: [Tracks]
}

struct Tracks {
    let trackName: String
}
