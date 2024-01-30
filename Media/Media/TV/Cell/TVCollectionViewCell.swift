//
//  TVCollectionViewCell.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class TVCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindResult(result: TVResult) {
        guard let imagePath = result.poster_path else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")
        imageView.kf.setImage(with: url)
    }
}

extension TVCollectionViewCell: CodeBase {
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(160)
        }
    }
    
    func configureView() {
        imageView.image = UIImage(systemName: "xmark")
        imageView.contentMode = .scaleAspectFit
    }
}
