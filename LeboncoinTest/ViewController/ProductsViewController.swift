//
//  ProductsViewController.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

private enum Constant {
   static let productCellIdentifer = "ProductCollectionViewCell"
    static let defaultCellIdentifier = "UICollectionViewCell"
}

class ProductsViewController: UIViewController {
    // MARK: - Properties
    private let interactor: CategoryAndProductInteractor
    private var collectionView: UICollectionView?
    private let geometry = ProductsCollectionViewGeometry()
    
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
        createCollectionView()
        configureCollectionView()
        fetchAndDisplayProducts()
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let collectionView = collectionView else { return }

        coordinator.animate(
            alongsideTransition: { _ in collectionView.collectionViewLayout.invalidateLayout() },
            completion: { _ in }
        )
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.productsViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productCell: ProductCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constant.productCellIdentifer,
                for: indexPath) as? ProductCollectionViewCell else {
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.defaultCellIdentifier,
                                                                 for: indexPath)
            return defaultCell
        }

        productCell.configure(with: interactor.productsViewModels[indexPath.row])
        return productCell
    }
}

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayDetail(for: interactor.productsViewModels[indexPath.row])
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
                strongSelf.displayProducts()
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

    func displayProducts() {
        collectionView?.reloadData()
    }
}

private extension ProductsViewController {
    func createCollectionView() {
        let collectionViewContainer = UIView()
        collectionViewContainer.backgroundColor = .white
        view.addSubview(collectionViewContainer)
        collectionViewContainer.pintTo(view)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .white
        collectionViewContainer.addSubview(collectionView)
        collectionView.pintTo(collectionViewContainer)
    }

    func configureCollectionView() {
        guard let collectionView = collectionView else { return }
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: Constant.productCellIdentifer)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.defaultCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard let containerFrame = collectionView.superview?.frame else {
                return CGSize.zero
            }


            let width = geometry.itemWidth(for: containerFrame.width)
            let height = width * geometry.itemAspectRatio
            return CGSize(width: width, height: height)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return geometry.itemSpacing
        }

        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return geometry.lineSpacing
        }

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          insetForSectionAt section: Int) -> UIEdgeInsets {
        return geometry.sectionInsets
    }
}
