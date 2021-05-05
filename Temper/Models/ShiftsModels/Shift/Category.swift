//
//  Category.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let id: String?
    let internalID: Int?
    let name: String?
    let nameTranslation: NameTranslation?
    let slug: String?
    let links: CategoryLinks?

    enum CodingKeys: String, CodingKey {
        case id
        case internalID = "internalId"
        case name
        case nameTranslation = "name_translation"
        case slug, links
    }
}
