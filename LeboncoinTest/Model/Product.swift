//
//  Product.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

struct Product: Decodable {
    let productID: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Int
    let imagesURL: ProductImages
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case productID = "id"
        case categoryId = "category_id"
        case title
        case description
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

struct ProductImages: Decodable {
    let small: String?
    let thumb: String?
}
