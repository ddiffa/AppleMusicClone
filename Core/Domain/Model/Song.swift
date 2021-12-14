//
//  Song.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import UIKit

public struct Song {
    public let id: String
    public let title: String
    public let duration: TimeInterval
    public let artist: String
    public let mediaURL: URL?
    public let coverArtImage: UIImage
}
