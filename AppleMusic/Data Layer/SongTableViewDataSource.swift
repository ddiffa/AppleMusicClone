//
//  SongTableViewDataSource.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import UIKit

class SongTableViewDataSource: NSObject {
    
    var dataStack: DataStack
    var managedTableView: UITableView
    
    init(tableView: UITableView) {
        dataStack = DataStack()
        
        managedTableView = tableView
        super.init()
        managedTableView.dataSource = self
    }
    
    func song(at index: Int) -> Song {
        let realIndex = index % dataStack.allSongs.count
        return dataStack.allSongs[realIndex]
    }
    
    func load() {
        dataStack.load()
        managedTableView.reloadData()
    }
    
}


extension SongTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataStack.allSongs.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        return configured(cell, at:indexPath)
    }
    
    func configured(_ cell: SongTableViewCell, at indexPath: IndexPath) -> SongTableViewCell {
        let song = song(at: indexPath.row)
        cell.songTitle.text = song.title
        cell.artistName.text = song.artist
        cell.coverArt.image = song.coverArtImage
        cell.songDuration.text = song.duration.toMinutesAndSecond()

        return cell
    }
    
}
