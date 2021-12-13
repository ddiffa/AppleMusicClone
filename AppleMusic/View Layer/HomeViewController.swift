//
//  ViewController.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 11/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerViewMiniPlayer: UIView!
    
    // MARK: Properties
    lazy var dataSource: SongTableViewDataSource = {
        let dataSource = SongTableViewDataSource(tableView: tableView)
        return dataSource
    }()
    
    private var currentIndex: IndexPath?

    var miniPlayer: MiniPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        dataSource.load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MiniPlayerViewController {
            miniPlayer = destination
            miniPlayer?.delegate = self
        }
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSong = dataSource.song(at: indexPath.row)
        currentIndex = indexPath
        guard let audioURL = currentSong.mediaURL else { return }
        containerViewMiniPlayer.isHidden = false
        
        miniPlayer?.currentSong = currentSong
        AudioHelper.shared.playAudio(audioURL: audioURL)
    }
}

extension HomeViewController: MiniPlayerViewControllerDelegate {
    func didTapStopBtn() {
        AudioHelper.shared.stopAudio()
        if let currentIndex = currentIndex {
            tableView.deselectRow(at: currentIndex, animated: false)
        }
        containerViewMiniPlayer.isHidden = true
    }
    
    func expandSong(currentSong: Song) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MusicDetailViewController") as? MusicDetailViewController {
            vc.delegate = self
            vc.currentSong = currentSong
            self.present(vc, animated: true)
        }
    }
}

extension HomeViewController: MusicDetailViewControllerDelegate {
    func didTapDetailStopBtn() {
        AudioHelper.shared.stopAudio()
        if let currentIndex = currentIndex {
            tableView.deselectRow(at: currentIndex, animated: false)
        }
        containerViewMiniPlayer.isHidden = true
    }
}
