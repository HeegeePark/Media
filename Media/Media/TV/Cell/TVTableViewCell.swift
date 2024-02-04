//
//  TVTableViewCell.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import UIKit

class TVTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVTableViewCell: CodeBase {
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.equalTo(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(160)
        }
    }
    
    func configureView() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    func configureCollectionView<T: BaseViewController>(target: T, tag: Int, title: String) {
        collectionView.delegate = target.self as? UICollectionViewDelegate
        collectionView.dataSource = target.self as? UICollectionViewDataSource
        collectionView.tag = tag
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        
        titleLabel.text = title
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.reloadData()
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
