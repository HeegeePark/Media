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
    case tvSeriesDetail(id: Int)
    case tvSeriesRecommendations(id: Int)
    case tvSeriesAggregateCredits(id: Int)
    case tvSearch(query: String)
    
    private var path: String {
        switch self {
        case .trending(let time_window):
            return "trending/tv/\(time_window.rawValue)"
        case .topRated:
            return "tv/top_rated"
        case .popular:
            return "tv/popular"
        case .tvSeriesDetail(let id):
            return "tv/\(id)"
        case .tvSeriesRecommendations(let id):
            return Self.tvSeriesDetail(id: id).path + "/recommendations"
        case .tvSeriesAggregateCredits(let id):
            return Self.tvSeriesDetail(id: id).path + "/aggregate_credits"
        case .tvSearch:
            return "search/tv"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var parameters: Parameters {
        switch self {
        case .tvSearch(let query):
            return ["query": query, "language": "ko-KR"]
        default:
            return ["language": "ko-KR"]
        }
    }
    
    var urlEncoding: URLEncoding {
        return URLEncoding(destination: .queryString)
    }
    
    var endpoint: String {
        return APIRouter.BaseURL + path
    }
}

enum TimeWindow: String {
    case day
    case week
}
