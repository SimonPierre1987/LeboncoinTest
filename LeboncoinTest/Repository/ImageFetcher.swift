//
//  ImageFetcher.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation
import UIKit

class ImageFetcher {
    // MARK: - Properties
    static let sharedInstance = ImageFetcher()
    private let cache = NSCache<NSString, UIImage>()

    // MARK: - Function
    func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        if let cachedImage = cache.object(forKey: NSString(string: url.absoluteString)) {
            completion(cachedImage)
            print("cache")
            return
        }
        print("not cache")
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.cache.setObject(image , forKey: NSString(string: url.absoluteString))
                completion(image)
            }
        }
    }
}
