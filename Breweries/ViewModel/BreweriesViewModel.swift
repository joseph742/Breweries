//
//  BreweriesViewModel.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI
import Combine

class BreweriesViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    @Published var breweries: [Brewery] = []

    func fetchBreweries() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openbrewerydb.org"
        components.path = "/breweries"

        let headers: BreweriesLogicController.Headers = ["application/json" : "Accept"]

        let networkController = NetworkController()
        let logicController = BreweriesLogicController(networkController: networkController)

        logicController
            .getBreweries(components: components, headers: headers)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [unowned self] breweries in
                self.breweries = breweries
            }
            .store(in: &subscriptions)
    }
}
