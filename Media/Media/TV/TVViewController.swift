//
//  TVViewController.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import UIKit

class TVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        TVAPI.shared.getTV(router: .popular) { result in
            print(result)
        }
    }
}
