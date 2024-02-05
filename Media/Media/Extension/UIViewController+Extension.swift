//
//  UIViewController+Extension.swift
//  Media
//
//  Created by 박희지 on 2/6/24.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(error: CustomError) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        
        let button4 = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(button4)
        
        // 4. 띄우기
        present(alert, animated: true)
    }
}
