//
//  Categories.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

struct Category: Decodable {
    let categoryId: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case name
    }
}

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
           return lhs.categoryId == rhs.categoryId
    }
}

extension Category {
    var categoryColor: UIColor {
        switch categoryId {
        case 1:
            return .blue
        case 2:
            return .brown
        case 3:
            return .systemTeal
        case 4:
            return .darkGray
        case 5:
            return .magenta
        case 6:
            return .purple
        case 7:
            return .red
        case 8:
            return .systemYellow
        case 9:
            return .systemRed
        case 10:
            return .systemGreen
        case 11:
            return .lightGray
        default:
            return .gray
        }
    }
}
