//
//  TVSeasonDetailTableViewCell.swift
//  Media
//
//  Created by 박희지 on 2/7/24.
//

import UIKit

class TVSeasonDetailTableViewCell: UITableViewCell {
    
    let seasonDetailView = TVSeasonDetailView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindInfo(model: TVSeriesSeasonDetailModel) {
        let info = DetailInfo(name: model.name,
                              firstAirYear: model.airDate, 
                              numberOfSeasons: model.seasonNumber,
                              numberOfEpisodes: model.episodes.count,
                              createdByName: nil,
                              backdropPath: model.posterPath,
                              overview: model.overview)
        
        seasonDetailView.bindInfo(info)
    }
    
}

extension TVSeasonDetailTableViewCell: CodeBase {
    func configureHierarchy() {
        contentView.addSubview(seasonDetailView)
    }
    
    func configureLayout() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        seasonDetailView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureView() {
    }
}
