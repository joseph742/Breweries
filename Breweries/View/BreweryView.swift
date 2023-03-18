//
//  BreweryView.swift
//  Breweries
//
//  Created by umoru joseph on 2023-03-18.
//

import SwiftUI

struct BreweryView: View {
    private let brewery: Brewery

    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: "beer")!)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 15) {
                Text(brewery.name)
                    .font(.system(size: 18))
                    .foregroundColor(Color.blue)

                Text("\(brewery.city) - \(brewery.street ?? "N/A")")
                    .font(.system(size: 14))
            }
        }
    }

    init(brewery: Brewery) {
        self.brewery = brewery
    }
}

struct BreweryView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryView(brewery: Brewery(name: "Guiness", street: "Halle berry", city: "Stockton"))
    }
}
