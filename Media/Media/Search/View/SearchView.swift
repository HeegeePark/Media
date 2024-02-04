//
//  SearchView.swift
//  Media
//
//  Created by 박희지 on 2/5/24.
//

import UIKit

class SearchView: BaseView {
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barStyle = .black
        sb.showsCancelButton = true
        sb.tintColor = .white
        return sb
    }()
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        cv.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        
        return cv
    }()
    
    override func configureHierarchy() {
        self.addSubviews(searchBar, collectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 0
        let spacing: CGFloat = 10
        
        let cellWidth = (UIScreen.main.bounds.width - inset * 2 - spacing * 2) / 3
        
        layout.itemSize = CGSize(width: cellWidth, height: 160)
        layout.sectionInset = .init(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        return layout
    }
}
