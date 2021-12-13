//
//  MusicDetailViewController.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import UIKit

class MusicDetailViewController: UIViewController {

    @IBOutlet weak var artisSong: UILabel!
    @IBOutlet weak var titleSong: UILabel!
    @IBOutlet var progressTimeSong: UIProgressView!
    @IBOutlet weak var thumbnailSong: UIImageView!
    
    @IBOutlet weak var currentLabelDuration: UILabel!
    @IBOutlet weak var maxDuration: UILabel!
    var currentSong: Song?
    
    weak var delegate: MusicDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        guard let currentSong = currentSong else {
            return
        }
        
        
        progressTimeSong.progress = Float(AudioHelper.shared.getCurrentTime() / currentSong.duration)
        
        currentLabelDuration.text = AudioHelper.shared.getCurrentTime().toMinutesAndSecond()
        maxDuration.text = currentSong.duration.toMinutesAndSecond()
        artisSong.text = currentSong.artist
        titleSong.text = currentSong.title
        thumbnailSong.image = currentSong.coverArtImage
    }
    
    @IBAction func didTapStopBtn(_ sender: Any) {
        delegate?.didTapDetailStopBtn()
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapPreviousBtn(_ sender: Any) {
        
    }
    
    @IBAction func didTapNextBtn(_ sender: Any) {
        
    }
}

protocol MusicDetailViewControllerDelegate: AnyObject {
    func didTapDetailStopBtn()
}
