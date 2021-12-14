//
//  MusicDetailViewController.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import UIKit
import Core

class MusicDetailViewController: UIViewController {

    @IBOutlet weak var artisSong: UILabel!
    @IBOutlet weak var titleSong: UILabel!
    @IBOutlet weak var thumbnailSong: UIImageView!
    
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var sliderSongDuration: UISlider!
    @IBOutlet weak var currentLabelDuration: UILabel!
    @IBOutlet weak var maxDuration: UILabel!
    var currentSong: Song?
    
    weak var delegate: MusicActionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        guard let currentSong = currentSong else {
            return
        }
        
        sliderSongDuration.minimumValue = 0
        sliderSongDuration.maximumValue = Float(currentSong.duration)
        sliderSongDuration.isContinuous = true
        maxDuration.text = currentSong.duration.toMinutesAndSecond()
        artisSong.text = currentSong.artist
        titleSong.text = currentSong.title
        thumbnailSong.image = currentSong.coverArtImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observePlayingTime()
    }
    
    private func observePlayingTime() {
        AudioHelper.shared.observePlayingTime(onPlaying: { time in
            self.sliderSongDuration.value = Float(time)
            self.currentLabelDuration.text = time.toMinutesAndSecond()
            
        }, onBuffering: { isBuffering in
            
        }, onNext: { cmTime in
            if cmTime.rounded() == self.currentSong?.duration {
                self.stopBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
                self.sliderSongDuration.value = 0.0
                self.currentLabelDuration.text = "00:00"
                AudioHelper.shared.stopAudio()
            }
        })
    }
    
    private func setStopBtnImage() {
        if AudioHelper.shared.isPlaying {
            stopBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            delegate?.didTapStopBtn()
        } else {
            observePlayingTime()
            stopBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            delegate?.didTapPlayBtn()
        }
    }
    
    @IBAction func didTapStopBtn(_ sender: Any) {
        setStopBtnImage()
    }
    
    @IBAction func didTapPreviousBtn(_ sender: Any) {
        
    }
    
    @IBAction func didTapNextBtn(_ sender: Any) {
        
    }
}
