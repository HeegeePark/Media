//
//  TVSeriesDetailsModel.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import Foundation

struct TVSeriesDetailsModel: Decodable {
    let id: Int
    let name: String
    let createdBy: [CreatedBy]
    let firstAirDate: String
    let genres: [Genre]
    
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let overview: String
    let posterPath: String
    let backdropPath: String
    let tagline: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case firstAirDate = "first_air_date"
        case genres
        case id
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case overview
        case posterPath = "poster_path"
        case tagline
    }
}

struct CreatedBy: Decodable {
    let name: String
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct Season: Decodable {
    let id: Int
    let episodeCount: Int
    let name, overview: String
    let posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
