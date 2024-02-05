//
//  ProfileViewController.swift
//  Media
//
//  Created by 박희지 on 2/5/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let mainView = ProfileView()
    
    var cast: Cast?
    
    override func loadView() {
        self.view = mainView
        
        if let cast {
            mainView.updateView(cast: cast)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindProfile(cast: Cast) {
        self.cast = cast
    }

}
