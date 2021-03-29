//
//  Categories.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

struct Category: Decodable {
    let categoryId: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case name
    }
}
