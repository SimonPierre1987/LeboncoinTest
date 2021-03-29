//
//  Product.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

struct Product: Decodable {
    let productId: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Int
    let images: ProductImages
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case productId = "id"
        case categoryId = "category_id"
        case title
        case description
        case price
        case images = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

struct ProductImages: Decodable {
    let smallImageURLString: String?
    let thumbnailURLString: String?

    enum CodingKeys: String, CodingKey {
        case smallImageURLString = "small"
        case thumbnailURLString = "thumb"
    }
}
