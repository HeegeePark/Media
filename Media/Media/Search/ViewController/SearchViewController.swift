//
//  SearchViewController.swift
//  Media
//
//  Created by 박희지 on 2/5/24.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    var list: [TVResult] = [] {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegate()
    }
}

extension SearchViewController {
    
    func configureDelegate() {
        mainView.searchBar.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        TVAPI.shared.request(router: .tvSearch(query: text), model: TVModel.self) { result in
            switch result {
            case .success(let success):
                self.list = success.results
            case .failure(let failure):
                self.presentErrorAlert(error: failure)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        let result = list[indexPath.item]
        cell.bindResult(result: result)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = list[indexPath.item]
        
        let vc = TVSeriesViewController()
        vc.bindTVSeries(id: result.id)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    SearchViewController()
}


