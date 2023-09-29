//
//  TV.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/28.
//

import Foundation

struct TVListModel: Decodable {
    let page: Int
    let results: [TV]
}

struct TV: Decodable, Hashable {
    let name: String
    let overview: String
    let posterURL: String
    let vote: String
    let firstAirDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAireDate = "first_air_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)
        let path = try container.decode(String.self, forKey: .posterPath)
        posterURL = "image.tmdb.org/t/p/w500/\(path)"
        let voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) \(voteCount)"
        firstAirDate = try container.decode(String.self, forKey: .firstAireDate)
    }
}
