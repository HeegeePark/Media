//
//  TVSeasonTableViewCEll.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit

// TV시리즈 시즌 정보 전용 테이블뷰 셀
class TVSeasonTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
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

extension TVSeasonTableViewCell: CodeBase {
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
        }
    }
    
    func configureView() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    func configureCollectionView<T: BaseViewController>(target: T, tag: Int, title: String) {
        collectionView.delegate = target.self as? UICollectionViewDelegate
        collectionView.dataSource = target.self as? UICollectionViewDataSource
        collectionView.tag = tag
        collectionView.register(TVSeasonCollectionViewCell.self, forCellWithReuseIdentifier: TVSeasonCollectionViewCell.identifier)
        
        titleLabel.text = title
        
        collectionView.isScrollEnabled = false
        collectionView.reloadData()
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        collectionView.frame = CGRect(x: collectionView.frame.origin.x, y: frame.origin.y, width: collectionView.frame.width, height: 1400)
        
        collectionView.layoutIfNeeded()
        
        let newCellSize = CGSize(width: collectionView.collectionViewLayout.collectionViewContentSize.width, height: collectionView.collectionViewLayout.collectionViewContentSize.height + 36)
        
        return newCellSize
    }
}
