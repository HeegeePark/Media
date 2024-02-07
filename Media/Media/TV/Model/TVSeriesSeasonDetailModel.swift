//
//  TVSeriesSeasonDetailModel.swift
//  Media
//
//  Created by 박희지 on 2/6/24.
//

import Foundation

struct TVSeriesSeasonDetailModel: Decodable {
    let id: Int
    let airDate: String
    let name: String
    let overview: String
    let posterPath: String
    let seasonNumber: Int
    let episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case id
        case airDate = "air_date"
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case episodes
    }
}

struct Episode: Decodable {
    let id: Int
    let airDate: String
    let episodeNumber: Int
    let name: String
    let overview: String
    let runtime: Int
    let stillPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case name
        case overview
        case runtime
        case stillPath = "still_path"
    }
}
