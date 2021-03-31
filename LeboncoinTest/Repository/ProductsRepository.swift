//
//  ProductsRepository.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

typealias ProductsHandler = (Result<[Product], LeboncoinError>) -> Void

protocol ProductsRepositoryProtocol {
    func fetchProducts(completion: @escaping ProductsHandler)
    var products: [Product] { get }
}

class ProductsRepository: ProductsRepositoryProtocol {
    // MARK: - Properties
    private let fetcher: FetcherProtocol
    private let productsUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    var products: [Product] = []

    // MARK: - Init
    init(fetcher: FetcherProtocol) {
        self.fetcher = fetcher
    }
    
    // MARK: - ProductsRepositoryProtocol
    func fetchProducts(completion: @escaping ProductsHandler) {
        fetcher.get([Product].self, at: productsUrlString) { [weak self] (result) in
            _ = result.map( { self?.products = $0 })
            completion(result)
        }
    }
}
