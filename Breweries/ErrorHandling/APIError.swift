//
//  APIError.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI

enum APIError: Error {

    case url(URLError?)
    case badResponse(statusCode: Int)
    case badURL
    case unknown(Error)
    case parsingError

    static func convert(error: Error) -> APIError {
        switch error {
        case is URLError:
            return .url(error as? URLError)
        case is APIError:
            return error as! APIError

        default:
            return .unknown(error)
        }
    }
}


extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badResponse(let statusCode):
            let format = NSLocalizedString(
                "The call failed with HTTP code '%@'",
                comment: ""
            )

            return String(format: format, String(statusCode))
        case .parsingError:
            return NSLocalizedString(
                "There was an error while trying to parse data.",
                comment: ""
            )
        case .badURL:
            return NSLocalizedString(
                "Couldn't create URL.",
                comment: ""
            )
        case .url(let error):
            return error?.localizedDescription
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
