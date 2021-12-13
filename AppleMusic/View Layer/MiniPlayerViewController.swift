//
//  MiniPlayerViewController.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import UIKit

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
    
    weak var delegate: MiniPlayerViewControllerDelegate?
    
    @IBOutlet weak var thumbnailSong: UIImageView!
    @IBOutlet weak var titleSong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapView(_ sender: Any) {
        guard let currentSong = currentSong else {
            return
        }

        delegate?.expandSong(currentSong: currentSong)
    }
    
    @IBAction func didTapStopBtn(_ sender: Any) {
        delegate?.didTapStopBtn()
    }
}

protocol MiniPlayerViewControllerDelegate: AnyObject {
    func didTapStopBtn()
    func expandSong(currentSong: Song)
}
