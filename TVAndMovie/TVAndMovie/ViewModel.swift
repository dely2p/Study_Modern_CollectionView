//
//  ViewModel.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/28.
//

import Foundation
import RxSwift

class ViewModel {
    let disposeBag = DisposeBag()
    
    private let tvNetwork: TVNetwork
    private let movieNetwork: MovieNetwork
    
    init() {
        let provider = NetworkProvider()
        tvNetwork = provider.makeTVNetwork()
        movieNetwork = provider.makeMovieNetwork()
    }
    
    // VC -> VM
    struct Input {
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    // VM -> VC
    struct Output {
        let tvList: Observable<[TV]>
        let movieList: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        let tvList = input.tvTrigger.flatMapLatest { [unowned self] _ -> Observable<[TV]> in
            return self.tvNetwork.getTopRatedList().map { $0.results }
        }
        
        let movieResult = input.movieTrigger.flatMapLatest { [unowned self] _ -> Observable<MovieResult> in
            Observable.combineLatest(self.movieNetwork.getUpcomingList(), self.movieNetwork.getPopularList(), self.movieNetwork.getNowPlayingList()) { upcoming, popular, nowPlaying -> MovieResult in
                return MovieResult(upcoming: upcoming, popular: popular, nowPlaying: nowPlaying)
            }
        }
        
        input.movieTrigger.bind {
            print("Movie Trigger")
        }.disposed(by: disposeBag)
        
        return Output(tvList: tvList, movieList: movieResult)
    }
}
