//
//  ShiftLinks.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - ShiftLinks
struct ShiftLinks: Codable {
    let linksSelf, matchAggregates, job: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case matchAggregates = "match_aggregates"
        case job
    }
}
