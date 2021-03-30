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
    private var productImageView: UIImageView?
    private var productTitleLabel: UILabel?
    private var productPriceLabel: UILabel?
    private var isUrgentView: IsUrgentView?
    private var stackView: UIStackView?

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
        productImageView?.cancelImageFetch()
        productImageView?.image = UIImage(named: Constant.productImagePlaceholder)
        productPriceLabel?.text = nil
        productTitleLabel?.text = nil
        isUrgentView?.setup(isUrgent: false)
    }

    // MARK: - Public Functions
    func configure(with product: ProductViewModel) {
        productTitleLabel?.text = product.title.uppercased()
        productPriceLabel?.text = product.convenientPrice.uppercased()
        productImageView?.fetchImage(at: product.imagesURL.compulsoryImageURL)
        isUrgentView?.setup(isUrgent: product.isUrgent)
        stackView?.setNeedsLayout()
    }
}

private extension ProductCollectionViewCell {
    func setupViews() {
        backgroundColor = .white
        setupImageView()
        setupTitle()
        setupPriceLabel()
        setupIsUrgentView()
        setupStackView()
    }

    func setupImageView() {
        productImageView = UIImageView(frame: CGRect.zero)
        guard let productImageView = productImageView else { return }

        productImageView.image = UIImage(named: Constant.productImagePlaceholder)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = Constant.productImageCornerRadius
        productImageView.set(aspectRatio: Constant.productImageRatio)
    }

    func setupTitle() {
        productTitleLabel = UILabel(frame: CGRect.zero)
        guard let productTitleLabel = productTitleLabel else { return }

        productTitleLabel.numberOfLines = 2
        productTitleLabel.font = UIFont.boldSystemFont(ofSize: Constant.fontSize)
        productTitleLabel.lineBreakMode = .byTruncatingTail
        productTitleLabel.allowsDefaultTighteningForTruncation = true
    }

    func setupIsUrgentView() {
        isUrgentView = IsUrgentView(frame: CGRect.zero)
    }

    func setupPriceLabel() {
        productPriceLabel = UILabel(frame: CGRect.zero)
        guard let productPriceLabel = productPriceLabel else { return }

        productPriceLabel.numberOfLines = 1
        productPriceLabel.font = UIFont.systemFont(ofSize: Constant.fontSize)
        productPriceLabel.textColor = .orange
        productPriceLabel.lineBreakMode = .byWordWrapping
        productPriceLabel.allowsDefaultTighteningForTruncation = true
    }

    func setupStackView() {
        guard let productImageView = productImageView,
              let productTitleLabel = productTitleLabel,
              let productPriceLabel = productPriceLabel,
              let isUrgentView = isUrgentView else {
            return
        }

        stackView = UIStackView(arrangedSubviews: [productImageView,
                                                   productTitleLabel,
                                                   productPriceLabel,
                                                   UIView(),
                                                   isUrgentView])
        guard let stackView = stackView else { return }

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constant.stackviewSpacing
        self.addSubview(stackView)
        stackView.pintTo(self)
    }
}
