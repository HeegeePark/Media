//
//  DynamicHeightCollectionView.swift
//  Media
//
//  Created by 박희지 on 2/2/24.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
    
}
