//
//  TVSeriesView.swift
//  Media
//
//  Created by 박희지 on 2/4/24.
//

import UIKit

class TVSeriesView: BaseView {
    let headerView: TVDetailView = TVDetailView(reuseIdentifier: TVDetailView.identifier)
    
    let tableView: UITableView = {
        let tb = UITableView()
        
        tb.rowHeight = UITableView.automaticDimension
        tb.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
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
