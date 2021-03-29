//
//  ProductDetailViewController.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    private let product: ProductViewModel

    // MARK: - Init
    init(product: ProductViewModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: UI
private extension ProductDetailViewController {
    func setupViews() {
        view.backgroundColor = .red
        title = product.title
        // TODO
    }
}
