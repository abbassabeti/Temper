//
//  NameTranslation.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - NameTranslation
struct NameTranslation: Codable {
    let enGB, nlNL: String?

    enum CodingKeys: String, CodingKey {
        case enGB = "en_GB"
        case nlNL = "nl_NL"
    }
}
