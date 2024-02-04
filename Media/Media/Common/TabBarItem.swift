//
//  TabBarItem.swift
//  Media
//
//  Created by 박희지 on 2/4/24.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case tv
    case tvSeries
}

extension TabBarItem {
    private var title: String {
        switch self {
        case .tv:
            return "TV"
        case .tvSeries:
            return "탐색"
        }
    }
}

extension TabBarItem {
    private var inactiveIcon: UIImage? {
        switch self {
        case .tv:
            return UIImage(systemName: "play.tv")
        case .tvSeries:
            return UIImage(systemName: "magnifyingglass")
        }
    }
    
    private var activeIcon: UIImage? {
        switch self {
        case .tv:
            return UIImage(systemName: "play.tv.fill")
        case .tvSeries:
            return UIImage(systemName: "magnifyingglass.fill")
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: inactiveIcon,
            selectedImage: activeIcon
        )
    }
}
