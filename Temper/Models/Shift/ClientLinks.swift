//
//  ClientLink.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - ClientLinks
struct ClientLinks: Codable {
    let heroImage, thumbImage: URL?

    enum CodingKeys: String, CodingKey {
        case heroImage = "hero_image"
        case thumbImage = "thumb_image"
    }
}
