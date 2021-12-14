//
//  Song.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import UIKit

public struct SongResponse: Codable {
    let id: String
    let title: String
    let duration: Double
    let artist: String
    let coverImageUrl: String
    let urlSong: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case duration
        case urlSong = "url_song"
        case coverImageUrl = "cover_image_url"
        case artist
    }
}

extension SongResponse {
    public func toDomain() -> Song {
        return .init(id: id,
                     title: title,
                     duration: duration,
                     artist: artist,
                     mediaURL: URL(string: urlSong),
                     coverArtImage: UIImage(named: "keshi")!)
    }
}


