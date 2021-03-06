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
    private let interactor: CategoryAndProductInteractorProtocol

    private let productCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())

    private let geometry = ProductsCollectionViewGeometry()

    private let categoryFiltersView = CategoryFiltersContainer()
    private var loadingView: LoadingView?

    // MARK: - Init
    init(interactor: CategoryAndProductInteractorProtocol) {
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
        setupProductCollectionView()
        configureCollectionView()
        setupFilterView()
        fetchAndDisplayProducts()
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _  in self?.productCollectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.currentProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productCell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.productCellIdentifer, for: indexPath) as? ProductCollectionViewCell else {
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.defaultCellIdentifier,
                                                                 for: indexPath)
            return defaultCell
        }

        productCell.configure(with: interactor.currentProducts[indexPath.row])
        return productCell
    }
}

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayDetail(for: interactor.currentProducts[indexPath.row])
    }
}

// MARK: Navigation
private extension ProductsViewController {
    func displayDetail(for product: ProductViewModel) {
        let detailViewController = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - ProductFiltersContainerDelegate
extension ProductsViewController: CategoryFiltersContainerDelegate {
    func userDidSelect(filter: CategoryFilter) {
        interactor.userDidSelectFilter(filter: filter)
        productCollectionView.reloadData()
        productCollectionView.setContentOffset(.zero, animated: false)
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
                strongSelf.displayCategoriesFilters()
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
        loadingView = LoadingView.showLoading(in: self.view)
    }

    func endLoading() {
        guard let loadingView = loadingView else { return }
        LoadingView.hide(loadingView: loadingView)
    }

    func display(error: LeboncoinError) {
        let alertView = UIAlertController(title: LeboncoinError.errorTitle,
                                          message: error.errorDisplayText,
                                          preferredStyle: .alert)
        let retryAction = UIAlertAction(title: LeboncoinError.retryTitle,
                                        style: .default) { [weak self] (_) in
            self?.fetchAndDisplayProducts()
        }
        let cancelAction = UIAlertAction(title: LeboncoinError.cancelTitle,
                                         style: .cancel,
                                         handler: nil)
        alertView.addAction(retryAction)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }

    func displayProducts() {
        productCollectionView.reloadData()
    }

    func displayCategoriesFilters() {
        categoryFiltersView.setup(with: interactor.categories, delegate: self)
    }
}

private extension ProductsViewController {
    func setupProductCollectionView() {
        let collectionViewContainer = UIView()
        collectionViewContainer.backgroundColor = .white
        view.addSubview(collectionViewContainer)
        collectionViewContainer.pinToSafeArea(view, marging: geometry.collectionViewContainerInsets)

        productCollectionView.backgroundColor = .white
        collectionViewContainer.addSubview(productCollectionView)
        productCollectionView.pinTo(collectionViewContainer)
    }

    func configureCollectionView() {
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: Constant.productCellIdentifer)
        productCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.defaultCellIdentifier)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }

    func setupFilterView() {
        view.addSubview(categoryFiltersView)
        categoryFiltersView.pinToSafeArea(view, height: geometry.categoryFiltersViewHeight)
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
