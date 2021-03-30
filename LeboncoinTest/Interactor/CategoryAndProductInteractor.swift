//
//  CategoryAndProductInteractor.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

typealias categoryAndProductCompletion = (Result<Bool, LeboncoinError>) -> Void

class CategoryAndProductInteractor {
    // MARK: - Properties
    private let productRepository: ProductsRepositoryProtocol
    private let categoryRepository: CategoriesRepositoryProtocol
    private var currentFilter: CategoryFilter = .noFilter
    private var productsViewModels: [ProductViewModel] = []

    private(set) var categories: [Category] = []

    var currentProducts: [ProductViewModel] {
        switch currentFilter {
        case .noFilter:
            return productsViewModels
        case let .filter(category: category):
            return productsViewModels.filter { $0.category == category}
        }
    }

    // MARK: - Init
    init() {
        let fetcher = Fetcher()
        productRepository = ProductsRepository(fetcher: fetcher)
        categoryRepository = CategoriesRepository(fetcher: fetcher)
    }

    // MARK: - Public Functions
    func start(_ completion: @escaping categoryAndProductCompletion) {
        self.fetchCategoriesAndProducts { [weak self] (result) in
            guard let strongSelf = self else { return }

            strongSelf.categories = strongSelf.categoryRepository.categories
            strongSelf.buildProductsViewModels()
            completion(result)
        }
    }

    func userDidSelectFilter(filter: CategoryFilter) {
        self.currentFilter = filter
    }
}

private extension CategoryAndProductInteractor {
    func fetchCategoriesAndProducts(_ completion: @escaping categoryAndProductCompletion) {
        categoryRepository.fetchCategories { [weak self] (categoriesResult) in
            guard let strongSelf = self else {
                completion(.failure(.other(localizedDescription: "dereferencement error")))
                return
            }

            switch categoriesResult {
            case let .failure(error):
                completion(.failure(error))
            case .success:
                strongSelf.productRepository.fetchProducts { (productsResult) in
                    switch productsResult {
                    case let .failure(error):
                        completion(.failure(error))
                    case .success:
                        completion(.success(true))
                    }
                }
            }
        }
    }

    func buildProductsViewModels() {
        let categories = categoryRepository.categories
        let products = productRepository.products
        productsViewModels =  products
            .compactMap( { ProductMapper.productViewModel(from: $0, with: categories) })
            .sorted()
    }
}
