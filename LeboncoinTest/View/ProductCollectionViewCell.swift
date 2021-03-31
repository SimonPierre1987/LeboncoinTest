//
//  ProductCollectionViewCell.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

private enum Constant {
    static let productImageRatio: CGFloat = 4/3
    static let productImageCornerRadius: CGFloat = 5.0
    static let stackviewSpacing: CGFloat = 5
    static let fontSize: CGFloat = 15
    static let productImagePlaceholder = "Placeholder"
}

class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private let productImageView = UIImageView()
    private let productTitleLabel = UILabel()
    private let productPriceLabel = UILabel()
    private let isUrgentView = IsUrgentView()
    private let stackView: UIStackView = UIStackView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func prepareForReuse() {
        productImageView.cancelImageFetch()
        productImageView.image = UIImage(named: Constant.productImagePlaceholder)
        productPriceLabel.text = nil
        productTitleLabel.text = nil
        isUrgentView.setup(isUrgent: false)
    }

    // MARK: - Public Functions
    func configure(with product: ProductViewModel) {
        productTitleLabel.text = product.title.uppercased()
        productPriceLabel.text = product.convenientPrice.uppercased()
        productImageView.fetchImage(at: product.imagesURL.lowerSizeImageURL)
        isUrgentView.setup(isUrgent: product.isUrgent)
        stackView.setNeedsLayout()
    }
}

private extension ProductCollectionViewCell {
    func setupViews() {
        backgroundColor = .white
        setupImageView()
        setupTitle()
        setupPriceLabel()
        setupStackView()
    }

    func setupImageView() {
        productImageView.image = UIImage(named: Constant.productImagePlaceholder)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = Constant.productImageCornerRadius
        productImageView.set(aspectRatio: Constant.productImageRatio)
    }

    func setupTitle() {
        productTitleLabel.numberOfLines = 2
        productTitleLabel.font = UIFont.boldSystemFont(ofSize: Constant.fontSize)
        productTitleLabel.lineBreakMode = .byTruncatingTail
        productTitleLabel.allowsDefaultTighteningForTruncation = true
    }

    func setupPriceLabel() {
        productPriceLabel.numberOfLines = 1
        productPriceLabel.font = UIFont.systemFont(ofSize: Constant.fontSize)
        productPriceLabel.textColor = .orange
        productPriceLabel.lineBreakMode = .byWordWrapping
        productPriceLabel.allowsDefaultTighteningForTruncation = true
    }

    func setupStackView() {
        _ = [productImageView,
         productTitleLabel,
         productPriceLabel,
         UIView(),
         isUrgentView]
            .map { stackView.addArrangedSubview($0) }

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constant.stackviewSpacing
        self.addSubview(stackView)
        stackView.pinTo(self)
    }
}
