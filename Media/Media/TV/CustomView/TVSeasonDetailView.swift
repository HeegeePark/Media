//
//  TVSeasonDetailView.swift
//  Media
//
//  Created by 박희지 on 2/7/24.
//

import UIKit

class TVSeasonDetailView: UITableViewHeaderFooterView {
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let overviewLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindInfo(_ info: DetailInfo) {
        posterImageView.setPoster(path: info.backdropPath)
        
        titleLabel.text = info.name
        
        let firstAirYear = info.firstAirYear.prefix(4)
        descriptionLabel.text = "\(info.numberOfEpisodes) 회차 • \(firstAirYear)"
        
        overviewLabel.text = info.overview
    }
}

extension TVSeasonDetailView {
    func configureHierarchy() {
        self.addSubviews(posterImageView, titleLabel, descriptionLabel, overviewLabel)
    }
    
    func configureLayout() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.top.equalTo(contentView).inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(contentView).inset(8)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(contentView).inset(8)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
        
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .lightText
        
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.textColor = .lightText
        overviewLabel.numberOfLines = 0
    }
}
