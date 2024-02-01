//
//  TVSeasonCollectionViewCell.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit

class TVSeasonCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let overviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindResult(result: Season) {
        guard let imagePath = result.posterPath else { return }
        imageView.setPoster(path: imagePath)
        
        nameLabel.text = result.name
        
        descriptionLabel.text = "\(result.episodeCount) 회차"
        
        let overview = !result.overview.isEmpty ? result.overview: "정보 없음"
        overviewLabel.text = overview
    }
}

extension TVSeasonCollectionViewCell: CodeBase {
    func configureHierarchy() {
        contentView.addSubviews(imageView, nameLabel, descriptionLabel, overviewLabel)
    }
    
    func configureLayout() {
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(110)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(16)
            make.width.equalTo(70)
            make.height.equalTo(110)
            make.centerY.equalTo(contentView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.leading.equalTo(nameLabel.snp.trailing).offset(12)
            make.trailing.greaterThanOrEqualTo(contentView).inset(16)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(4).priority(.high)
            make.bottom.equalTo(imageView.snp.bottom).priority(.medium)
        }
    }
    
    func configureView() {
        
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        nameLabel.sizeToFit()
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .lightText
        
        overviewLabel.font = .systemFont(ofSize: 13)
        overviewLabel.textColor = .lightText
        overviewLabel.numberOfLines = 0
    }
}
