//
//  TVSeriesAggregateCreditsModel.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import Foundation

// MARK: - TVSeriesAggregateCreditsModel
struct TVSeriesAggregateCreditsModel: Decodable {
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let roles: [Role]?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case roles
        case order
    }
}

struct Role: Decodable {
    let character: String
}

