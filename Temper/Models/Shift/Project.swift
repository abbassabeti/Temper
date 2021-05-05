//
//  Project.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - Project
struct Project: Codable {
    let id, name: String?
    let client: Client?

    enum CodingKeys: String, CodingKey {
        case id, name
        case client
    }
}
