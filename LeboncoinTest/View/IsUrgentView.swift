//
//  IsUrgentView.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

private enum Constant {
    static let fontSize: CGFloat = 15
}

class IsUrgentView: UIView {
    // MARK: - Properties
    private var isUrgentLabel: UILabel?
    private var isUrgentLabelContainer: UIView?
    private var stackView: UIStackView?

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
        guard let isUrgentLabelContainer = isUrgentLabelContainer else { return }

        isUrgentLabelContainer.layer.cornerRadius = frame.size.height / 2
    }

    // MARK: - Public Functions
    func setup(isUrgent: Bool) {
        isUrgentLabel?.text = isUrgent ? "Urgent" : ""
        isUrgentLabelContainer?.isHidden = !isUrgent
    }
}


private extension IsUrgentView {

    func setupViews() {
        setupIsUrgentLabel()
        setupStackView()
    }
    
    func setupIsUrgentLabel() {
        isUrgentLabelContainer = UIView(frame: CGRect.zero)
        isUrgentLabel = UILabel(frame: CGRect.zero)
        guard let isUrgentLabel = isUrgentLabel,
              let isUrgentLabelContainer = isUrgentLabelContainer else { return }

        isUrgentLabel.numberOfLines = 1
        isUrgentLabel.font = UIFont.systemFont(ofSize: Constant.fontSize)
        isUrgentLabel.textColor = .white
        isUrgentLabel.textAlignment = .center
        isUrgentLabel.backgroundColor = .clear
        isUrgentLabel.lineBreakMode = .byWordWrapping
        isUrgentLabel.allowsDefaultTighteningForTruncation = true
        isUrgentLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        isUrgentLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        isUrgentLabelContainer.backgroundColor = .orange
        isUrgentLabelContainer.addSubview(isUrgentLabel)
        isUrgentLabel.pinTo(isUrgentLabelContainer,
                            marging: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }

    func setupStackView() {
        guard let isUrgentLabelContainer = isUrgentLabelContainer else { return }

        stackView = UIStackView(arrangedSubviews: [isUrgentLabelContainer, UIView()])
        guard let stackView = stackView else { return }

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        self.addSubview(stackView)
        stackView.pinTo(self)
    }
}
