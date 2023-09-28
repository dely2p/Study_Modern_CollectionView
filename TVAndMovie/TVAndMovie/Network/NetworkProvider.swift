//
//  NetworkProvider.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/28.
//

import Foundation

final class NetworkProvider {
    private let endpoint: String
    init() {
        self.endpoint = "https://api.themoviedb.org/3"
    }
    
    func makeTVNetwork() -> TVNetwork {
        let network = Network<TVListModel>(endpoint: endpoint)
        return TVNetwork(network: network)
    }
    
    func makeMovieNetwork() -> MovieNetwork {
        let network = Network<MovieListModel>(endpoint: endpoint)
        return MovieNetwork(network: network)
    }
}
