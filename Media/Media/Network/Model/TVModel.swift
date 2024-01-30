//
//  TrendingModel.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import Foundation

struct TVModel: Decodable {
    let results: [TVResult]
}

struct TVResult: Decodable {
    let id: Int
    let name: String
    let original_name: String
    let poster_path: String?
    let backdrop_path: String?
}
