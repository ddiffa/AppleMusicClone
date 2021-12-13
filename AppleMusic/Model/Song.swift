//
//  Song.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import Foundation
import UIKit

struct Song {
    let id: String = UUID().uuidString
    let title: String
    var duration: TimeInterval = 0
    let artist: String
    var mediaURL: URL?
    var coverArtImage: UIImage?
}
