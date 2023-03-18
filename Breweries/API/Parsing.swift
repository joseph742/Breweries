//
//  Parsing.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
    let decoder = JSONDecoder()

    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
        .parsingError
        }
        .eraseToAnyPublisher()
}
