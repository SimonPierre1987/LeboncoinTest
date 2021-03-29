//
//  CategoriesRepository.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

typealias CategoryHandler = (Result<Categories, Error>) -> Void

protocol CategoriesRepositoryProtocol {
    func fetchCategories(completion: @escaping CategoryHandler)
}

class CategoriesRepository: CategoriesRepositoryProtocol {
    
    // MARK: - CategoriesRepositoryProtocol
    func fetchCategories(completion: @escaping CategoryHandler) {
    }
}
