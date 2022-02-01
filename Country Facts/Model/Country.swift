//
//  Country.swift
//  Country Facts
//
//  Created by António Rocha on 17/12/2021.
//

import UIKit

struct Country: Codable {
    var flag: String
    var name: String
    var capital: String
    var region: String
    var subregion: String
    var currencies: [Currency]
    var area: Double?
    var population: Int
}
