//
//  Reusable.swift
//  Media
//
//  Created by 박희지 on 1/30/24.
//

import UIKit

protocol Reusable: AnyObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return NSObject.description()
    }
}

extension UIViewController: Reusable {}
extension UIView: Reusable {}

