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
    case tvSeriesSeasonDetail(seriesId: Int, seasonNumber: Int)
    
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
        case .tvSeriesSeasonDetail(seriesId: let seriesId, seasonNumber: let seasonNumber):
            return "tv/\(seriesId)/season/\(seasonNumber)"
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
    
    // MARK: - for URLSession
    
    var queryItems: [URLQueryItem] {
        return parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: endpoint)!
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.headers = headers
        return request
    }
}

enum TimeWindow: String {
    case day
    case week
}
