//
//  TVSeriesViewController.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit
import SnapKit

class TVSeriesViewController: BaseViewController {
    
    let mainView = TVSeriesView()
    
    enum Category: String, CaseIterable {
        case casts = "출연진"
        case seasons = "시즌 정보"
        case recommendations = "비슷한 추천 작품"
    }
    
    var id = 0
    
    var casts: [Cast] = []
    var seasons: [Season] = []
    var reocmmendataions: [TVSeriesResult] = []
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        
        fetchTVSeries()
    }
    
    func bindTVSeries(id: Int) {
        self.id = id
    }
    
    func fetchTVSeries() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.request(router: .tvSeriesDetail(id: self.id), model: TVSeriesDetailsModel.self) { result in
                switch result {
                case .success(let success):
                    
                    let info = DetailInfo(name: success.name, firstAirYear: success.firstAirDate, numberOfSeasons: success.numberOfSeasons, numberOfEpisodes: success.numberOfEpisodes, createdByName: success.createdBy.map { $0.name }, backdropPath: success.backdropPath, overview: success.overview)
                    
                    self.mainView.headerView.bindInfo(info)
                    self.seasons = success.seasons
                    
                case .failure(let failure):
                    self.presentErrorAlert(error: failure)
                }
                
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.request(router: .tvSeriesRecommendations(id: self.id), model: TVSeriesRecommendationsModel.self) { result in
                
                switch result {
                case .success(let success):
                    self.reocmmendataions = success.results
                case .failure(let failure):
                    self.presentErrorAlert(error: failure)
                }
                
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.request(router: .tvSeriesAggregateCredits(id: self.id), model: TVSeriesAggregateCreditsModel.self) { result in
                
                switch result {
                case .success(let success):
                    self.casts = success.cast
                case .failure(let failure):
                    self.presentErrorAlert(error: failure)
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }
    
    func count(type: Category) -> Int {
        switch type {
        case .casts:
            return casts.count
        case .seasons:
            return seasons.count
        case .recommendations:
            return reocmmendataions.count
        }
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TVSeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return mainView.headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Category.allCases[indexPath.row] {
        case .seasons:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TVSeasonTableViewCell.identifier, for: indexPath) as! TVSeasonTableViewCell
            
            cell.configureCollectionView(target: self, tag: indexPath.row, title: Category.allCases[indexPath.row].rawValue)
            
            return cell
        
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
            
            cell.configureCollectionView(target: self, tag: indexPath.row, title: Category.allCases[indexPath.row].rawValue)
            
            return cell
        }
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = Category.allCases[collectionView.tag]
        return count(type: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch Category.allCases[collectionView.tag] {
        
        case .casts:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
            
            let result = casts[indexPath.item].profilePath
            cell.bindPoster(path: result)
            
            return cell
            
        case .recommendations:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
            
            let result = reocmmendataions[indexPath.item].posterPath
            cell.bindPoster(path: result)
            
            return cell
            
        case .seasons:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeasonCollectionViewCell.identifier, for: indexPath) as! TVSeasonCollectionViewCell
            
            let result = seasons[indexPath.item]
            cell.bindResult(result: result)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch Category.allCases[collectionView.tag] {
        
        case .casts:
            let cast = casts[indexPath.item]
            
            let vc = ProfileViewController()
            
            vc.bindProfile(cast: cast)
            
            present(vc, animated: true)
            
        case .seasons:
            let season = seasons[indexPath.item]
            
            let vc = TVSeriesSeasonDetailViewController()
            
            vc.bindSeason(seriesId: id, seasonNumber: season.seasonNumber)
            
            navigationController?.pushViewController(vc, animated: true)
        
        case .recommendations:
            // TODO: 작품 세부정보 화면 연결
            return
        }
    }
}

struct DetailInfo {
    let name: String
    let firstAirYear: String
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    let createdByName: [String]?
    let backdropPath: String
    let overview: String
}
