//
//  Country.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let iso31661, human: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso3166_1"
        case human
    }
}
