//
//  ProductFilterView.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

protocol CategoryFiltersContainerDelegate: class {
    func userDidSelect(filter: CategoryFilter)
}

private enum Constant {
    static let categoryFilterCellIdentifer = "CategoryFilterCollectionViewCell"
    static let defaultCellIdentifier = "UICollectionViewCell"
}

class CategoryFiltersContainer: UIView {
    // MARK: Properties
    private var collectionView: UICollectionView?
    private var categories: [Category] = []
    private var selectedFilter: CategoryFilter = .noFilter

    private var geometry = CategoryFiltersCollectionViewGeometry()
    private weak var delegate: CategoryFiltersContainerDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCollectionView()
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Functions
    func setup(with categories: [Category],
               delegate: CategoryFiltersContainerDelegate) {
        self.categories = categories
        self.delegate = delegate
        collectionView?.reloadData()
    }
}

// MARK: Navigation
private extension CategoryFiltersContainer {
    func userDidSelect(filter: CategoryFilter) {
        selectedFilter = filter
        delegate?.userDidSelect(filter: filter)
        collectionView?.reloadData()
    }
}

extension CategoryFiltersContainer: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productFilterCell: CategoryFilterCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constant.categoryFilterCellIdentifer,
                for: indexPath) as? CategoryFilterCollectionViewCell else {
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.defaultCellIdentifier,
                                                                 for: indexPath)
            return defaultCell
        }

        let currentFilter = filter(for: indexPath)
        productFilterCell.setup(with: currentFilter,
                                isSelected: currentFilter == selectedFilter)
        return productFilterCell
    }
}

extension CategoryFiltersContainer: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilter = filter(for: indexPath)
        userDidSelect(filter: selectedFilter)
    }
}

// MARK: - UI
private extension CategoryFiltersContainer {
    func createCollectionView() {
        let collectionViewContainer = UIView()
        collectionViewContainer.backgroundColor = .white
        self.addSubview(collectionViewContainer)
        collectionViewContainer.pinTo(self, marging: geometry.collectionViewContainerInsets)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .white
        collectionViewContainer.addSubview(collectionView)
        collectionView.pinTo(collectionViewContainer)
    }

    func configureCollectionView() {
        guard let collectionView = collectionView else { return }
        collectionView.register(CategoryFilterCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constant.categoryFilterCellIdentifer)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: Constant.defaultCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func filter(for indexPath: IndexPath) -> CategoryFilter {
        return indexPath.row == 0 ? .noFilter : .filter(category: categories[indexPath.row - 1])
    }
}

extension CategoryFiltersContainer: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: geometry.itemWidth, height: geometry.itemHeight)
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
