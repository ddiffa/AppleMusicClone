//
//  SongRepository.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import RxSwift

public protocol SongRepository {
    func fetchSongs() -> Observable<SongRequest.Response>
}
