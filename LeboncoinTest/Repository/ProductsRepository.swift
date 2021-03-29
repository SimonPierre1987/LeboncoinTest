//
//  ProductsRepository.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

typealias ProductsHandler = (Result<Products, LeboncoinError>) -> Void

protocol ProductsRepositoryProtocol {
    func fetchProducts(completion: @escaping ProductsHandler)
}

class ProductsRepository: ProductsRepositoryProtocol {
    private let fetcher: Fetcher
    private let productsUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"

    // MARK: - Init
    init(fetcher: Fetcher) {
        self.fetcher = fetcher
    }
    
    // MARK: - ProductsRepositoryProtocol
    func fetchProducts(completion: @escaping ProductsHandler) {
        fetcher.getData(at: productsUrlString) { (resul) in
            // TODO
            completion(.failure(.emptyData))
        }
    }
}
