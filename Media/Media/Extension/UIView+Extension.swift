//
//  UIView+Extension.swift
//  Media
//
//  Created by 박희지 on 2/1/24.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}
