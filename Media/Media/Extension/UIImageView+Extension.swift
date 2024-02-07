//
//  UIImageView+Extension.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setPoster(path: String) {
        self.contentMode = .scaleAspectFill
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        self.kf.setImage(with: url)
    }
}
