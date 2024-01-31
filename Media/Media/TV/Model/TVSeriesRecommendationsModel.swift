//
//  TVSeriesRecommendationsModel.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import Foundation

struct TVSeriesRecommendationsModel: Decodable {
    let results: [TVSeriesResult]
}

struct TVSeriesResult: Decodable {
    let id: Int
    let name: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
    }
}
