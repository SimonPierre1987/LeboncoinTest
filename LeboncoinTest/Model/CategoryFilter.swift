//
//  ProductFilter.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

enum CategoryFilter {
    case filter(category: Category)
    case noFilter
}

extension CategoryFilter {
    var displayName: String {
        switch self {
        case .noFilter:
            return "Tout"
        case let .filter(category: category):
            return category.name
        }
    }

    var color: UIColor {
        switch self {
        case .noFilter:
            return .black
        case let .filter(category: category):
            return category.categoryColor
        }
    }
}

extension CategoryFilter: Equatable {
    static func == (lhs: CategoryFilter, rhs: CategoryFilter) -> Bool {
        switch (lhs, rhs) {
        case (.noFilter, .noFilter):
            return true
        case let (.filter(category: lhsCategory), .filter(category: rhsCategory)):
            return lhsCategory == rhsCategory
        default:
            return false
        }
    }
}
