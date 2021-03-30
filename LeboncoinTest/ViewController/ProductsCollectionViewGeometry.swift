//
//  ProductsCollectionViewGeometry.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

struct ProductsCollectionViewGeometry {
    let collectionViewContainerInsets =  UIEdgeInsets(top: 10,
                                                      left: 0,
                                                      bottom: 10,
                                                      right: 0)

    let sectionInsets = UIEdgeInsets(top: 50.0,
                                     left: 20.0,
                                     bottom: 50.0,
                                     right: 20.0)

    let itemSpacing: CGFloat = 20
    let lineSpacing: CGFloat = 25

    let itemAspectRatio: CGFloat = 2

    func numberOfItemPerRow(for width: CGFloat) -> Int {
        if width < 500 {
            return 2
        } else {
            return 4
        }
    }

    func widthPadding(for width: CGFloat) -> CGFloat {
        return sectionInsets.right + sectionInsets.left + CGFloat((numberOfItemPerRow(for: width) - 1)) * itemSpacing
    }

    func itemWidth(for width: CGFloat) -> CGFloat {
        return (width - widthPadding(for: width)) / CGFloat(numberOfItemPerRow(for: width))
    }
}
