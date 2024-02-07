//
//  TVSeriesSeasonDetailViewController.swift
//  Media
//
//  Created by 박희지 on 2/7/24.
//

import UIKit

class TVSeriesSeasonDetailViewController: BaseViewController {
    
    let mainView = TVSeriesSeasonDetailView()
    
    enum Category: String, CaseIterable {
        case seasonInfo
        case episode = "에피소드 정보"
    }
    
    var seriesId = 0
    var seasonNumber = 0
    
    var model: TVSeriesSeasonDetailModel? {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        
        do {
            try fetchSeasonDetail()
        } catch {
            let dismiss: () -> Void = {
                self.navigationController?.popViewController(animated: true)
            }
            
            presentErrorAlert(error: error as! CustomError, dismiss)
        }
    }
    
    func bindSeason(seriesId: Int, seasonNumber: Int) {
        self.seriesId = seriesId
        self.seasonNumber = seasonNumber
    }
    
    func fetchSeasonDetail() throws {
        guard seriesId != 0 else {
            throw CustomError.invalidPath
        }
        
        TVAPI.shared.request(router: .tvSeriesSeasonDetail(seriesId: seriesId, seasonNumber: seasonNumber), model: TVSeriesSeasonDetailModel.self) { result in
            switch result {
            case .success(let success):
                self.model = success
                
            case .failure(let failure):
                
                let dismiss: () -> Void = {
                    self.navigationController?.popViewController(animated: true)
                }
                
                self.presentErrorAlert(error: failure, dismiss)
            }
        }
    }
    
    func setDelegate() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TVSeriesSeasonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Category.allCases[indexPath.row] {
        case .seasonInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: TVSeasonDetailTableViewCell.identifier, for: indexPath) as! TVSeasonDetailTableViewCell
            
            if let model {
                cell.bindInfo(model: model)
            }
            
            return cell
        case .episode:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TVSeasonTableViewCell.identifier, for: indexPath) as! TVSeasonTableViewCell
            
            cell.configureCollectionView(target: self, tag: indexPath.row, title: Category.episode.rawValue)
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TVSeriesSeasonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.episodes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeasonCollectionViewCell.identifier, for: indexPath) as! TVSeasonCollectionViewCell
        
        let episode = model!.episodes[indexPath.item]
        
        cell.bindEpisode(result: episode)
        
        return cell
        
        
        
    }
}

