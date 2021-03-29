//
//  Fetcher.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 29/03/2021.
//

import Foundation

enum LeboncoinError: Error {
    case badURLFormat
    case badHTTPResponse
    case emptyData
    case other(error: Error)
}

class Fetcher {

    func getData(at urlString: String,
                 _ completion: @escaping (Result<(Data, HTTPURLResponse), LeboncoinError>) -> Void) {
        privateGetData(at: urlString) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    // MARK: Private
    private func privateGetData(at urlString: String,
                                _ completion: @escaping (Result<(Data, HTTPURLResponse), LeboncoinError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURLFormat))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error: error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.badHTTPResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }

            completion(.success((data, httpResponse)))
        }.resume()
    }
}
