//
//  ProductViewModel.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

struct ProductViewModel {
    let productID: Int
    let category: Category
    let title: String
    let description: String
    let price: Int
    let imagesURL: ProductImagesViewModel
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?

    var convenientPrice: String {
        return "\(price) €"
    }
}

struct ProductImagesViewModel {
    let smallImageURL: URL?
    let thumbnailURL: URL?
    let compulsoryImageURL: URL // thumbnailURL if it exists or smallImageURL
}
