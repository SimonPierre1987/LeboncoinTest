//
//  ProductCollectionViewCell.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var productImageView: UIImageView?

    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Functions
    func configure(with product: ProductViewModel) {
        ImageFetcher.sharedInstance.loadFrom(url: product.imagesURL.compulsoryImageURL) { [weak self] (image) in
            guard let image = image else { return }
            self?.productImageView?.image = image
        }
    }

    override func prepareForReuse() {
        productImageView?.image = UIImage(named: "Placeholder")
    }
}

private extension ProductCollectionViewCell {
    func setupViews() {
        productImageView = UIImageView(frame: CGRect.zero)
        productImageView?.image = UIImage(named: "Placeholder")
        guard let productImageView = productImageView else { return }
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .yellow
        self.addSubview(productImageView)
        productImageView.pintTo(self)
    }
}
