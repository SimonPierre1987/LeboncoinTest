//
//  CategoriesRepository.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

typealias CategoriesHandler = (Result<[Category], LeboncoinError>) -> Void

protocol CategoriesRepositoryProtocol {
    func fetchCategories(completion: @escaping CategoriesHandler)
}

class CategoriesRepository: CategoriesRepositoryProtocol {
    private let categoryUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
    private let fetcher: Fetcher

    // MARK: - Init
    init(fetcher: Fetcher) {
        self.fetcher = fetcher
    }

    // MARK: - CategoriesRepositoryProtocol
    func fetchCategories(completion: @escaping CategoriesHandler) {
        fetcher.get([Category].self, at: categoryUrlString) { (result) in
            completion(result)
        }
    }
}
