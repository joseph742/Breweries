//
//  BreweriesLogicController.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI
import Combine

protocol BreweriesLogicControllerProtocol: AnyObject {
    typealias Headers = [String: Any]

    var networkController: NetworkControllerProtocol { get }

    func getBreweries(components: URLComponents, headers: Headers) -> AnyPublisher<[Brewery], APIError>
}


class BreweriesLogicController: BreweriesLogicControllerProtocol {
    var networkController: NetworkControllerProtocol

    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }

    func getBreweries(components: URLComponents, headers: Headers) -> AnyPublisher<[Brewery], APIError> {
        return networkController.get(type: [Brewery].self, components: components, headers: headers)
    }
}
