//
//  TVSeriesViewController.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit
import SnapKit

class TVSeriesViewController: UIViewController {
    
    let headerView = TVDetailView(frame: .zero)
    let tableView = UITableView()
    
    enum Category: String, CaseIterable {
        case casts = "출연진"
//        case seasons = "시즌 정보"
        case recommendations = "비슷한 추천 작품"
    }
    
    var casts: [Cast] = []
//    var seasons: [Season] = []
    var reocmmendataions: [TVSeriesResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
        configureTableView()
        
        fetchTVSeries()
    }
    
    func fetchTVSeries() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.getTVSeries(router: .tvSeriesDetail, model: TVSeriesDetailsModel.self) { result in
                let info = DetailInfo(name: result.name, firstAirYear: result.firstAirDate, numberOfSeasons: result.numberOfSeasons, numberOfEpisodes: result.numberOfEpisodes, createdByName: result.createdBy.map { $0.name }, backdropPath: result.backdropPath, overview: result.overview)
                
                self.headerView.bindInfo(info)
//                self.seasons = result.seasons
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.getTVSeries(router: .tvSeriesRecommendations, model: TVSeriesRecommendationsModel.self) { result in
                self.reocmmendataions = result.results
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            TVAPI.shared.getTVSeries(router: .tvSeriesAggregateCredits, model: TVSeriesAggregateCreditsModel.self) { result in
                self.casts = result.cast
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("finsishsihfshh")
            self.tableView.reloadData()
        }
    }
    
    func count(type: Category) -> Int {
        switch type {
        case .casts:
            return casts.count
//        case .seasons:
//            return seasons.count
        case .recommendations:
            return reocmmendataions.count
        }
    }
}

extension TVSeriesViewController {
    func configureHierarchy() {
        view.addSubviews(headerView, tableView)
    }
    
    func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(380)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TVSeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
        
        cell.configureCollectionView(target: self, tag: indexPath.row, title: Category.allCases[indexPath.row].rawValue)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = Category.allCases[collectionView.tag]
        return count(type: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        var result: String?
        switch Category.allCases[collectionView.tag] {
        
        case .casts:
            result = casts[indexPath.item].profilePath
        case .recommendations:
            result = reocmmendataions[indexPath.item].posterPath
        }
        
        if let result {
            cell.bindPoster(path: result)
        }
        
        return cell
    }
}

struct DetailInfo {
    let name: String
    let firstAirYear: String
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    let createdByName: [String]
    let backdropPath: String
    let overview: String
}

#Preview {
    TVSeriesViewController()
}
