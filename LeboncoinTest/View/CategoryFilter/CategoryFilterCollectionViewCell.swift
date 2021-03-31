//
//  ProductFilterView.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

class CategoryFilterCollectionViewCell: UICollectionViewCell {
    private let filterLabel = UILabel()

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
    func setup(with filter: CategoryFilter,
               isSelected: Bool) {
        filterLabel.text = filter.displayName
        filterLabel.textColor = isSelected ? .white : .black

        layer.borderColor = filter.color.cgColor
        backgroundColor = isSelected ? filter.color : .white
    }
}

private extension CategoryFilterCollectionViewCell {
    func setupViews() {
        backgroundColor = .clear
        layer.borderWidth = 1.0
        filterLabel.font = UIFont.systemFont(ofSize: 17)
        filterLabel.textAlignment = .center
        filterLabel.numberOfLines = 2
        filterLabel.lineBreakMode = .byWordWrapping
        filterLabel.allowsDefaultTighteningForTruncation = true
        addSubview(filterLabel)
        filterLabel.pinTo(self, marging: .zero)
    }
}

