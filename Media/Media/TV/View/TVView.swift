//
//  TVView.swift
//  Media
//
//  Created by 박희지 on 2/4/24.
//

import UIKit

class TVView: BaseView {
    let tableView: UITableView = {
        let tb = UITableView()
        tb.rowHeight = UITableView.automaticDimension
        tb.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tb.separatorStyle = .none
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
