//
//  ReportAtAddressLink.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - ReportAtAddressLinks
struct ReportAtAddressLinks: Codable {
    let getDirections: String

    enum CodingKeys: String, CodingKey {
        case getDirections = "get_directions"
    }
}
