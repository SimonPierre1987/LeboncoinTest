//
//  ProductsViewController.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

class ProductsViewController: UIViewController {
    private let interactor: CategoryAndProductInteractor
    // MARK: - Init
    init(interactor: CategoryAndProductInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchAndDisplayProducts()
    }
}

// MARK: Navigation
private extension ProductsViewController {
    func displayDetail(for product: ProductViewModel) {
        let detailViewController = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: Data
private extension ProductsViewController {
    func fetchAndDisplayProducts() {
        startLoading()
        interactor.start { [weak self] (result) in
            guard let strongSelf = self else { return }

            strongSelf.endLoading()
            switch result {
            case let .failure(error):
                strongSelf.display(error: error)
            case .success:
                strongSelf.display(products: strongSelf.interactor.productsViewModels)
            }
        }
    }
}

// MARK: UI
private extension ProductsViewController {
    func setupViews() {
        view.backgroundColor = .white
        title = "LeBonCoinTest"
    }


    func startLoading() {
        // TODO
    }

    func endLoading() {
        // TODO
    }

    func display(error: LeboncoinError) {
        // TODO
    }

    func display(products: [ProductViewModel]) {
        // TODO
    }
}
