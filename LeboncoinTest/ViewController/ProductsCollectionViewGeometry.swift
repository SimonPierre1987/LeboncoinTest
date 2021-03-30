//
//  ProductsCollectionViewGeometry.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

struct ProductsCollectionViewGeometry {
    var collectionViewContainerInsets: UIEdgeInsets {
        return UIEdgeInsets(top: categoryFiltersViewHeight,
                            left: 0,
                            bottom: 10,
                            right: 0)
    }

    let sectionInsets = UIEdgeInsets(top: 20,
                                     left: 20,
                                     bottom: 20,
                                     right: 20)

    let itemSpacing: CGFloat = 20
    let lineSpacing: CGFloat = 25
    let categoryFiltersViewHeight: CGFloat = 100

    let itemAspectRatio: CGFloat = 2/1

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
