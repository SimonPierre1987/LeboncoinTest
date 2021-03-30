//
//  ProductFilterView.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

class CategoryFilterView: UICollectionViewCell {
    private var filterLabel: UILabel?

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func layoutSubviews() {
        layer.cornerRadius = frame.size.height / 2
    }

    // MARK: - Public Functions
    func setup(with filter: ProductFilter,
               isSelected: Bool) {
        filterLabel?.text = filter.displayName
        backgroundColor = isSelected ? filter.color : .white
    }
}

private extension CategoryFilterView {
    func setupViews() {
        backgroundColor = .clear
        filterLabel = UILabel.init(frame: CGRect.zero)
        guard let filterLabel = filterLabel else { return }

        addSubview(filterLabel)
        filterLabel.pinTo(self, marging: UIEdgeInsets(top: 1, left: 5, bottom: 5, right: 5))
    }
}

