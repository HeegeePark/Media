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
        
        TVAPI.shared.request(router: .tvSearch(query: text), model: TVModel.self) { response in
            self.list = response.results
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
}

#Preview {
    SearchViewController()
}


