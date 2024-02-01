//
//  TVDetailView.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit

class TVDetailView: UITableViewHeaderFooterView {
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let creatorLabel = UILabel()
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
        descriptionLabel.text = "\(info.numberOfSeasons) 시즌 • \(info.numberOfEpisodes) 회차 • \(firstAirYear)"
        
        creatorLabel.text = "크리에이터 " + info.createdByName.joined(separator: ", ")
        overviewLabel.text = info.overview
    }
}

extension TVDetailView {
    func configureHierarchy() {
        self.addSubviews(posterImageView, titleLabel, descriptionLabel, creatorLabel, overviewLabel)
    }
    
    func configureLayout() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(8)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(8)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(creatorLabel.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalTo(contentView).inset(8)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
        
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .lightText
        
        creatorLabel.font = .systemFont(ofSize: 15)
        creatorLabel.textColor = .lightText
        
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.textColor = .lightText
        overviewLabel.numberOfLines = 3
    }
}
