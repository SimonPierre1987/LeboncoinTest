//
//  ImageFetcher.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation
import UIKit

protocol UIImageFetcherProtocol {
    func fetchImage(at url: URL, for imageView: UIImageView)
    func cancelImageFetch(for imageView: UIImageView)
}

class UIImageFetcher: UIImageFetcherProtocol {
    // MARK: - Properties
    static let sharedInstance = UIImageFetcher(imageFetcher: ImageFetcher.sharedInstance)
    private let imageFetcher: ImageFetcherProtocol
    private var uuidMap: [ImageWrapper: UUID] = [:]

    // MARK: - Init
    init(imageFetcher: ImageFetcherProtocol) {
        self.imageFetcher = imageFetcher
    }

    // MARK: - UIImageFetcherProtocol
    func fetchImage(at url: URL, for imageView: UIImageView) {
        let imageWrapper = ImageWrapper(imageView: imageView)

        let token = imageFetcher.fetchImage(at: url) { result in
            defer { self.uuidMap.removeValue(forKey: imageWrapper) }

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
            uuidMap[imageWrapper] = token
        }
    }

    func cancelImageFetch(for imageView: UIImageView) {
        let imageWrapper = ImageWrapper(imageView: imageView)

        if let uuid = uuidMap[imageWrapper] {
            imageFetcher.cancelImageFetch(uuid)
            uuidMap.removeValue(forKey: imageWrapper)
        }
    }
}

protocol ImageFetcherProtocol {
    func fetchImage(at url: URL,
                    _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelImageFetch(_ uuid: UUID)
}

private class ImageFetcher: ImageFetcherProtocol {
    // MARK: - Properties
    static let sharedInstance = ImageFetcher()
    private let imageCache = NSCache<NSString, UIImage>()
    private var runningRequests: [UUID: URLSessionDataTask] = [:]

    // MARK: - ImageFetcherProtocol
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

/* The wrapper prevents the imageView from being retain */
private class ImageWrapper: Hashable {
    // MARK: - Properties
    weak var imageView: UIImageView?

    // MARK: - Init
    init(imageView: UIImageView) {
        self.imageView = imageView
    }

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageView)
    }

    static func == (lhs: ImageWrapper, rhs: ImageWrapper) -> Bool {
        guard let lhsImageView = lhs.imageView,
              let rhsImageView = rhs.imageView else {
            return false
        }

        return lhsImageView.hashValue == rhsImageView.hashValue
    }
}
