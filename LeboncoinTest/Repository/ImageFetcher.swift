//
//  ImageFetcher.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation
import UIKit

class UIImageFetcher {
    // MARK: - Properties
    static let sharedInstance = UIImageFetcher()
    private let imageFetcher = ImageFetcher()
    private var uuidMap: [UIImageView: UUID] = [:]

    // MARK: - Public Functions
    func fetchImage(at url: URL, for imageView: UIImageView) {
        let token = imageFetcher.fetchImage(at: url) { result in

            defer { self.uuidMap.removeValue(forKey: imageView) }

            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    imageView.image = image
                }
            case .failure:
                break
            }
        }

        if let token = token {
            uuidMap[imageView] = token
        }
    }

    func cancelImageFetch(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageFetcher.cancelImageFetch(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

private class ImageFetcher {
    // MARK: - Properties
    private let imageCache = NSCache<NSString, UIImage>()
    private var runningRequests: [UUID: URLSessionDataTask] = [:]

    // MARK: - Functions
    func fetchImage(at url: URL,
                    _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            completion(.success(cachedImage))
            return nil
        }

        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            defer { self?.runningRequests.removeValue(forKey: uuid) }

            if let data = data, let image = UIImage(data: data) {
                self?.imageCache.setObject(image , forKey: NSString(string: url.absoluteString))
                completion(.success(image))
                return
            }

            guard let error = error else { return }

            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }

    func cancelImageFetch(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
