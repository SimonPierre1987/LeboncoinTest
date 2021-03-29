//
//  ProductsRepository.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

typealias ProductsHandler = (Result<Products, Error>) -> Void

protocol ProductsRepositoryProtocol {
    func fetchProducts(completion: @escaping ProductsHandler)
}

class ProductsRepository: ProductsRepositoryProtocol {

    // MARK: - ProductsRepositoryProtocol
    func fetchProducts(completion: @escaping ProductsHandler) {
        // TODO
    }
}
