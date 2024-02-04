//
//  BaseViewController.swift
//  Media
//
//  Created by 박희지 on 2/2/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
    }
}
