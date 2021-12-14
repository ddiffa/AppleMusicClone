//
//  DefaultSongRepository.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import RxSwift
import Alamofire

public final class DefaultSongRepository {
    private let networkApi: NetworkAPI<SongRequest>
    
    init() {
        networkApi = NetworkAPI()
    }
}

extension DefaultSongRepository: SongRepository {
    public func fetchSongs() -> Observable<SongRequest.Response> {
        return networkApi.fetch(SongRequest())
    }
}
