//
//  TVSeriesViewController.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit

class TVSeriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchTVSeries()
    }
    
    func fetchTVSeries() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.getTVSeries(router: .tvSeriesDetail, model: TVSeriesDetailsModel.self) { result in
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.getTVSeries(router: .tvSeriesRecommendations, model: TVSeriesRecommendationsModel.self) { result in
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.getTVSeries(router: .tvSeriesAggregateCredits, model: TVSeriesAggregateCreditsModel.self) { result in
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("finsishsihfshh")
        }
    }
}
