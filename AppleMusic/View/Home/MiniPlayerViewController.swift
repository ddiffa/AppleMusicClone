//
//  MiniPlayerViewController.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import UIKit
import Core

class MiniPlayerViewController: UIViewController {
    
    var currentSong: Song? {
        didSet {
            guard let currentSong = currentSong else {
                return
            }
            
            thumbnailSong.image = currentSong.coverArtImage
            titleSong.text = currentSong.title
        }
    }
    
    weak var stopMusicDelegate: MusicActionDelegate?
    weak var musicPlayerDelegate: MusicPlayerDelegate?
    
    @IBOutlet weak var thumbnailSong: UIImageView!
    @IBOutlet weak var titleSong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapView(_ sender: Any) {
        guard let currentSong = currentSong else {
            return
        }

        musicPlayerDelegate?.expandSong(currentSong: currentSong)
    }
    
    @IBAction func didTapStopBtn(_ sender: Any) {
        stopMusicDelegate?.didTapStopBtn()
    }
}

protocol MusicActionDelegate: AnyObject {
    func didTapStopBtn()
    func didTapPlayBtn()
}

protocol MusicPlayerDelegate: AnyObject {
    func expandSong(currentSong: Song)
}
