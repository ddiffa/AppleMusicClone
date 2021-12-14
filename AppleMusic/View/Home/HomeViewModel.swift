//
//  HomeViewModel.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import RxSwift
import Core
import RxRelay

class HomeViewModel {
    
    let songs: PublishSubject<[Song]> = PublishSubject<[Song]>()
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    private let useCase: SongUseCase
    
    private let disposeBag = DisposeBag()
    
    init() {
        useCase = DefaultSongUseCase()
    }
    
    func fetch() {
        useCase.fetch()
            .subscribe(onNext: { response in
                let songs = response.map { songResponse in
                    songResponse.toDomain()
                }
                self.songs.onNext(songs)
                self.songs.onCompleted()
                self.isLoading.accept(false)
            }, onError: { err in
                print(err.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
