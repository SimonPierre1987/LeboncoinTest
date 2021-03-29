//
//  Product.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let category_id: Int
    let title: String
    let description: String
    let price: Int
    let images: ProductImages
    let creation_date: String
    let is_urgent: Bool
    let siret: String?
}

struct Products: Decodable {
    let products: [Product]
}

struct ProductImages: Decodable {
    let small: String
    let thumb: String
}
