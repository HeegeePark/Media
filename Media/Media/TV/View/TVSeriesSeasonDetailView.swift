//
//  TVSeriesSeasonDetailView.swift
//  Media
//
//  Created by 박희지 on 2/7/24.
//

import UIKit

class TVSeriesSeasonDetailView: BaseView {
    let tableView: UITableView = {
        let tb = UITableView()
        
        tb.rowHeight = UITableView.automaticDimension
        tb.register(TVSeasonDetailTableViewCell.self, forCellReuseIdentifier: TVSeasonDetailTableViewCell.identifier)
        tb.register(TVSeasonTableViewCell.self, forCellReuseIdentifier: TVSeasonTableViewCell.identifier)
        
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        
        tb.sectionHeaderHeight = UITableView.automaticDimension
        tb.estimatedSectionHeaderHeight = 300
        
        return tb
    }()
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
    }
}
