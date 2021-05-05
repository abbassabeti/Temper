//
//  ReportAtAddress.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - ReportAtAddress
struct ReportAtAddress: Codable {
    let zipCode, street, number, numberWithExtra: String
    let extra, city, line1, line2: String
    let links: ReportAtAddressLinks
    let country: Country
    let geo: Geo
    let region: String

    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case street, number
        case numberWithExtra = "number_with_extra"
        case extra, city, line1, line2, links, country, geo, region
    }
}
