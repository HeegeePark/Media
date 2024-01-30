//
//  APIRouter.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import Foundation
import Alamofire

enum APIRouter {
    private static let BaseURL = "https://api.themoviedb.org/3/"
    
    case trending(time_window: TimeWindow)
    case topRated
    case popular
    
    private var path: String {
        switch self {
        case .trending(let time_window):
            return "trending/tv/\(time_window.rawValue)"
        case .topRated:
            return "tv/top_rated"
        case .popular:
            return "tv/popular"
        }
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    private var query: String {
        return "?language=ko-KR"
    }
    
    var requestURL: String {
        return APIRouter.BaseURL + path + query
    }
}

enum TimeWindow: String {
    case day
    case week
}
