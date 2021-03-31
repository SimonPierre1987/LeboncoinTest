//
//  LoadingView.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 31/03/2021.
//

import UIKit

private enum Constant {
    static let appearingTime: TimeInterval = 0.0
    static let disappearingTime: TimeInterval = 0.3
}

class LoadingView: UIView {
    // MARK: - Properties
    let loader: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Functions
    static func showLoading(in view: UIView) -> LoadingView {
        let loadingView = LoadingView(frame: CGRect.zero)
        view.addSubview(loadingView)
        loadingView.pinTo(view)
        loadingView.loader.startAnimating()
        loadingView.alpha = 0.0
        UIView.animate(withDuration: Constant.appearingTime) {
            loadingView.alpha = 1.0
        }
        return loadingView
    }

    static func hide(loadingView: LoadingView) {
        UIView.animate(withDuration: Constant.disappearingTime) {
            loadingView.alpha = 0.0
        } completion: { (_) in
            loadingView.removeFromSuperview()
        }
    }
}

private extension LoadingView {
    func setupViews() {
        self.addSubview(loader)
        backgroundColor = .orange
        loader.pinTo(self)
    }
}
