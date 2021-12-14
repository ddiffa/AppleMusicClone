//
//  ViewController.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 11/12/21.
//

import UIKit
import Core
import RxSwift

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerViewMiniPlayer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        // MARK: Properties
    var viewModel: HomeViewModel?
    
    private var currentIndex: IndexPath?
    var miniPlayer: MiniPlayerViewController?
    private let disposeBag = DisposeBag()
    
    private var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel?.fetch()
        bind()
    }
    
    private func bind() {
        viewModel?.songs
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { songs in
                self.songs = songs
            }, onCompleted: {
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel?.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                if isLoading {
                    self.activityIndicator.isHidden = false
                } else {
                    self.activityIndicator.isHidden = true
                }
            }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MiniPlayerViewController {
            miniPlayer = destination
            miniPlayer?.stopMusicDelegate = self
            miniPlayer?.musicPlayerDelegate = self
        }
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSong = songs[indexPath.row]
        currentIndex = indexPath
        guard let audioURL = currentSong.mediaURL else { return }
        containerViewMiniPlayer.isHidden = false
        
        miniPlayer?.currentSong = currentSong
        AudioHelper.shared.playAudio(audioURL: audioURL)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        return configured(cell, at:indexPath)
    }
    
    func configured(_ cell: SongTableViewCell, at indexPath: IndexPath) -> SongTableViewCell {
        let song = songs[indexPath.row]
        cell.songTitle.text = song.title
        cell.artistName.text = song.artist
        cell.coverArt.image = song.coverArtImage
        cell.songDuration.text = song.duration.toMinutesAndSecond()
        
        return cell
    }
    
}


extension HomeViewController: MusicActionDelegate {
    func didTapStopBtn() {
        AudioHelper.shared.stopAudio()
        if let currentIndex = currentIndex {
            tableView.deselectRow(at: currentIndex, animated: false)
        }
        containerViewMiniPlayer.isHidden = true
    }
    
    func didTapPlayBtn() {
        guard let currentIndex = currentIndex,
              let audioUrl = self.songs[currentIndex.row].mediaURL else { return }
        AudioHelper.shared.playAudio(audioURL: audioUrl)
        containerViewMiniPlayer.isHidden = false
    }
}

extension HomeViewController: MusicPlayerDelegate {
    func expandSong(currentSong: Song) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MusicDetailViewController") as? MusicDetailViewController {
            vc.delegate = self
            vc.currentSong = currentSong
            self.present(vc, animated: true)
        }
    }
}
