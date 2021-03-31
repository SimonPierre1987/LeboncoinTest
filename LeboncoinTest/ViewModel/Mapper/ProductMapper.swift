//
//  ProductMapper.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

class ProductMapper {
    private static let dateFormatter = ISO8601DateFormatter()

    static func productViewModel(from product: Product,
                                 with categories: [Category]) -> ProductViewModel? {
        // The business logic requires a product to have a creation date
        guard let creationDate = dateFormatter.date(from:product.creationDate) else {
            return nil
        }

        // The business logic requires a product to have an image
        guard let productImagesViewModel = ProductImagesMapper.productImagesViewModel(from: product.images) else {
            return nil
        }

        // The business logic requires a product to have a category
        guard let productCategory = categories.first(where: { $0.categoryId == product.categoryId }) else {
            return nil
        }

        return ProductViewModel(productId: product.productId,
                                category: productCategory,
                                title: product.title,
                                description: product.description,
                                price: product.price,
                                imagesURL: productImagesViewModel,
                                creationDate: creationDate,
                                isUrgent: product.isUrgent,
                                siret: product.siret)
    }
}

class ProductImagesMapper {
    static func productImagesViewModel(from productImage: ProductImages) -> ProductImagesViewModel? {
        let smallImageURL: URL?
        let thumbnailURL: URL?

        if let smallImageURLString = productImage.smallImageURLString {
            smallImageURL = URL(string: smallImageURLString)
        } else {
            smallImageURL = nil
        }

        if let thumbnailURLString = productImage.thumbnailURLString {
            thumbnailURL = URL(string: thumbnailURLString)
        } else {
            thumbnailURL = nil
        }

        // The business logic requires a product to have an image
        // A valid image URL is the minimum requirement
        guard let compulsoryImageURL = thumbnailURL ?? smallImageURL else {
            return nil
        }

        return ProductImagesViewModel(smallImageURL: smallImageURL,
                                      thumbnailURL: thumbnailURL,
                                      compulsoryImageURL: compulsoryImageURL)
    }
}
