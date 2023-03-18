//
//  NetworkController.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI
import Combine

protocol NetworkControllerProtocol: AnyObject {
    typealias Headers = [String: Any]

    typealias Body = [URLQueryItem]

    func get<T>(type: T.Type, components: URLComponents, headers: Headers) -> AnyPublisher<T, APIError> where T: Decodable

    func post<T>(type: T.Type, components: URLComponents, headers: Headers, body: Body) -> AnyPublisher<T, APIError> where T: Decodable
}

class NetworkController: NetworkControllerProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
      self.session = session
    }

    func get<T>(type: T.Type, components: URLComponents, headers: Headers) -> AnyPublisher<T, APIError> where T : Decodable {
        guard let url = components.url else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                APIError.convert(error: error)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }

    func post<T>(type: T.Type, components: URLComponents, headers: Headers, body: Body) -> AnyPublisher<T, APIError> where T : Decodable {
        guard let url = components.url else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = body

        urlRequest.httpBody = requestBodyComponents.query?.data(using: .utf8)


        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                APIError.convert(error: error)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
