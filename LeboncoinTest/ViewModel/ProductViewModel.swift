//
//  ProductViewModel.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

struct ProductViewModel {
    let productId: Int
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

    static let dateFormatter = DateFormatter()

    var convenientDate: String {
        ProductViewModel.dateFormatter.dateStyle = .short
        return "Parue le \(ProductViewModel.dateFormatter.string(from: creationDate))"
    }

    var offerType: String? {
        return siret == nil ? "Annonce d'un particulier" : "Annonce professionelle"
    }
}

extension ProductViewModel: Comparable {
    static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
           return lhs.productId == rhs.productId
    }

    static func < (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        switch (lhs.isUrgent, rhs.isUrgent) {
        case (true, true):
            return lhs.creationDate < rhs.creationDate
        case (true, false):
            return true
        case (false, true):
            return false
        case (false, false):
            return lhs.creationDate < rhs.creationDate
        }
    }
}

struct ProductImagesViewModel {
    let smallImageURL: URL?
    let thumbnailURL: URL?
    let lowerSizeImageURL: URL // smallImageURL if it exists or thumbnailURL
}

