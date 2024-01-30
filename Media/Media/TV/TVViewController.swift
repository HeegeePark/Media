//
//  TVViewController.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import UIKit
import SnapKit

class TVViewController: UIViewController {
    
    enum Category: String, CaseIterable {
        case trending = "요즘 트렌드는 이 시리즈!"
        case topRated = "이번주 TOP10 TV시리즈"
        case popular = "믿고 보는 인기 TV시리즈"
        
        var router: APIRouter {
            switch self {
            case .trending:
                return .trending(time_window: .day)
            case .topRated:
                return .topRated
            case .popular:
                return .popular
            }
        }
    }
    
    let tableView = UITableView()
    
    var list: [[TVResult]] = Array(repeating: [], count: Category.allCases.count) {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureTableView()
        
        fetchAllResult()
    }
    
    func fetchAllResult() {
        for i in 0..<Category.allCases.count {
            let category = Category.allCases[i]
            fetchTVResult(router: category.router, idx: i)
        }
    }
    
    func fetchTVResult(router: APIRouter, idx: Int) {
        TVAPI.shared.getTV(router: router) { results in
            self.list[idx] = Array(results[0..<10])
        }
    }
}

// MARK: - Custom UI

extension TVViewController: CodeBase {
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
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

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        let result = list[collectionView.tag][indexPath.item]
        cell.bindResult(result: result)
        
        return cell
    }
}

