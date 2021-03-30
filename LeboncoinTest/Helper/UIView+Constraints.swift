//
//  UIView+Constraints.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import UIKit

extension UIView {

    func pinToSafeArea(_ view: UIView, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func pinTo(_ view: UIView, marging: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: marging.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: marging.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -marging.right).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -marging.bottom).isActive = true
    }

    func pinToSafeArea(_ view: UIView, marging: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: marging.top).isActive = true
        leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marging.left).isActive = true
        trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marging.right).isActive = true
        bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -marging.bottom).isActive = true
    }

    func pinTo(_ view: UIView) {
        pinTo(view, marging: .zero)
    }

    func set(aspectRatio: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: self,
                                         attribute: NSLayoutConstraint.Attribute.height,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.width,
                                         multiplier: aspectRatio,
                                         constant: 0))
    }
}
