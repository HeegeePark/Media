//
//  ProfileView.swift
//  Media
//
//  Created by 박희지 on 2/5/24.
//

import UIKit

class ProfileView: BaseView {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let characterLabel = UILabel()
    
    override func configureHierarchy() {
        self.addSubviews(imageView, nameLabel, characterLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(120)
            make.height.equalTo(160)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
    }
    
    override func configureView() {
        self.backgroundColor = .black
        
        imageView.contentMode = .scaleAspectFill
        
        [nameLabel, characterLabel].forEach { label in
            label.font = .boldSystemFont(ofSize: 17)
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 0
        }
    }
    
    func updateView(cast: Cast) {
        if let path = cast.profilePath {
            imageView.setPoster(path: path)
        }
        
        nameLabel.text = cast.name
        characterLabel.text = cast.roles?.first?.character ?? ""
    }
}
