//
//  DataStack.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import UIKit

enum DataStackState {
    case unloaded
    case loaded
}

class DataStack: NSObject {
    
    private(set) var allSongs: [Song] = []
    
    func load() {
        let song1 = Song(title: "To The Bone",
                         duration: 5 * 60 + 53,
                         artist: "Pamungkas",
                         mediaURL: URL(fileURLWithPath: Bundle.main.path(forResource: "pamungkas-tothebone", ofType: "mp3")!),
                         coverArtImage: UIImage(named:"pamungkas"))
        
        let song2 = Song(title: "Paragraphs",
                         duration: 3 * 60 + 54,
                         artist: "Luke Chiang",
                         mediaURL: URL(fileURLWithPath: Bundle.main.path(forResource: "luke-paragraphs", ofType: "mp3")!),
                         coverArtImage: UIImage(named:"luke"))
        
        let song3 = Song(title: "Skeletons",
                         duration: 172,
                         artist: "Keshi",
                         mediaURL: URL(fileURLWithPath: Bundle.main.path(forResource: "keshi-skeletons", ofType: "mp3")!),
                         coverArtImage: UIImage(named:"keshi"))
            allSongs.append(song1)
        
            allSongs.append(song2)
        
            allSongs.append(song3)
    }
}
