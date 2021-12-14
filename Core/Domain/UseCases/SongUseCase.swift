//
//  SongUseCase.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import RxSwift

public protocol SongUseCase {
    func fetch() -> Observable<SongRequest.Response>
}

public final class DefaultSongUseCase: SongUseCase {
    private let songRepository: SongRepository
    
    public init() {
        songRepository = DefaultSongRepository()
    }
    
    public func fetch() -> Observable<SongRequest.Response> {
        return songRepository.fetchSongs()
    }
}
