//
//  ProductDetailViewController.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

private enum Constant {
    static let productImageCornerRadius: CGFloat = 5.0
    static let stackviewSpacing: CGFloat = 20
    static let horizontalstackviewSpacing: CGFloat = 5
    static let fontSize: CGFloat = 15
    static let smallfontSize: CGFloat = 10
    static let productImagePlaceholder = "Placeholder"
}

class ProductDetailViewController: UIViewController {
    private let product: ProductViewModel
    private let scrollView = UIScrollView()
    private let scrollViewContentView = UIView()
    private let stackView = UIStackView()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let isUrgentView = IsUrgentView()
    private let titleLabel = UILabel()
    private let creationDateLabel = UILabel()
    private let productImageView = UIImageView()

    // MARK: - Init
    init(product: ProductViewModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureWithProduct()
    }
}

// MARK: UI
private extension ProductDetailViewController {
    func configureWithProduct() {
        title = product.offerType
        priceLabel.text = product.convenientPrice.uppercased()
        descriptionLabel.text = product.description
        productImageView.fetchImage(at: product.imagesURL.thumbnailURL ?? product.imagesURL.lowerSizeImageURL)
        isUrgentView.setup(isUrgent: product.isUrgent)
        creationDateLabel.text = product.convenientDate
        titleLabel.text = product.title
        stackView.setNeedsLayout()
    }

    func setupViews() {
        view.backgroundColor = .white
        setupScrollView()
        setupImageView()
        setupDescriptionLabel()
        setupPriceLabel()
        setupTitleLabel()
        setupDateLabel()
        setupStackView()
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.pinToSafeArea(view, marging: .zero)
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.pinTo(scrollView)
        let heightConstraint = scrollViewContentView.heightAnchor
            .constraint(equalTo: scrollView.heightAnchor,
                        constant: 0)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        scrollViewContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                     constant: 0).isActive = true
    }

    func setupStackView() {
        scrollViewContentView.addSubview(stackView)
        stackView.pinTo(scrollViewContentView, marging: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constant.stackviewSpacing

        let horizontalStack = horizontalStackView()
        _ = [isUrgentView,
             creationDateLabel].map({ horizontalStack.addArrangedSubview($0) })

        _ = [productImageView,
             titleLabel,
             horizontalStack,
             priceLabel,
             descriptionLabel].map({ stackView.addArrangedSubview($0) })
    }

    func setupImageView() {
        productImageView.image = UIImage(named: Constant.productImagePlaceholder)
        productImageView.contentMode = .center
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = Constant.productImageCornerRadius
    }

    func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: Constant.fontSize)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.allowsDefaultTighteningForTruncation = true
    }

    func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constant.fontSize)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.allowsDefaultTighteningForTruncation = true
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }

    func setupDateLabel() {
        creationDateLabel.numberOfLines = 1
        creationDateLabel.font = UIFont.italicSystemFont(ofSize: Constant.fontSize)
        creationDateLabel.lineBreakMode = .byWordWrapping
        creationDateLabel.allowsDefaultTighteningForTruncation = true
    }

    func setupPriceLabel() {
        priceLabel.numberOfLines = 1
        priceLabel.font = UIFont.systemFont(ofSize: Constant.fontSize)
        priceLabel.textColor = .orange
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.allowsDefaultTighteningForTruncation = true
    }

    func horizontalStackView() -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = Constant.horizontalstackviewSpacing
        return horizontalStackView
    }
}
