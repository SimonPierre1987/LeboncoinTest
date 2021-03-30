//
//  UIImageView+ImageFetcher.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 30/03/2021.
//

import UIKit

extension UIImageView {

    func fetchImage(at url: URL) {
        UIImageFetcher.sharedInstance.fetchImage(at: url, for: self)
    }

    func cancelImageFetch() {
        UIImageFetcher.sharedInstance.cancelImageFetch(for: self)
    }
}
