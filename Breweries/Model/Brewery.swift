//
//  Brewery.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI

struct Brewery: Decodable, Hashable {
    let name: String
    let street: String?
    let city: String
}
