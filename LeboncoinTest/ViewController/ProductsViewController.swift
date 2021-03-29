//
//  ProductsViewController.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

class ProductsViewController: UIViewController {
    private let productsRepository: ProductsRepositoryProtocol

    // MARK: - Init
    init(productsRepository: ProductsRepositoryProtocol) {
        self.productsRepository = productsRepository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        productsRepository.fetchProducts { (productResult) in
            // TODO
        }
    }
}

private extension ProductsViewController {
    func setupViews() {
        view.backgroundColor = .white
    }
}
