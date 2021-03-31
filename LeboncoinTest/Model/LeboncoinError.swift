//
//  LeboncoinError.swift
//  LeboncoinTest
//
//  Created by Simon Pierre on 31/03/2021.
//

import Foundation

enum LeboncoinError: Error {
    case badURLFormat
    case badHTTPResponse
    case missingData
    case parsingError(localizedDescription: String)
    case other(localizedDescription: String)
}

extension LeboncoinError {
    static let errorTitle: String = "An error occured"
    static let retryTitle: String = "Retry"
    static let cancelTitle: String = "Cancel"
    
    var errorDisplayText: String {
        switch self  {
        case .badURLFormat:
            return "Bad URL Format"
        case .badHTTPResponse:
            return "Network error"
        case .missingData:
            return "No data to load"
        case let .parsingError(localizedDescription: description):
            return description
        case let .other(localizedDescription: description):
            return description
        }
    }
}
