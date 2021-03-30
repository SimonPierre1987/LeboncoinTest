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
    case missingData
    case parsingError(error: Error)
    case other(localizedDescription: String)
}

class Fetcher {
    // MARK: - Public Functions
    func get<T: Decodable>(_ type: T.Type, at urlString: String,
                         _ completion: @escaping (Result<T, LeboncoinError>) -> Void) {
        getDataOnMainThread(at: urlString) { (result) in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success((jsonData, _)):
                do {
                    let parsedData = try JSONDecoder().decode(type, from: jsonData)
                    completion(.success(parsedData))
                } catch {
                    completion(.failure(.parsingError(error: error)))
                }
            }
        }
    }
}

private extension Fetcher {
    func getDataOnMainThread(at urlString: String,
                 _ completion: @escaping (Result<(Data, HTTPURLResponse), LeboncoinError>) -> Void) {
        getData(at: urlString) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func getData(at urlString: String,
                 _ completion: @escaping (Result<(Data, HTTPURLResponse), LeboncoinError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURLFormat))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(localizedDescription: error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.badHTTPResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.missingData))
                return
            }

            completion(.success((data, httpResponse)))
        }.resume()
    }
}
