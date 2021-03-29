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
        interactor.start { (result) in
        }
    }
}

private extension ProductsViewController {
    func setupViews() {
        view.backgroundColor = .white
    }
}
