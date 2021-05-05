//
//  JobLinks.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - JobLinks
struct JobLinks: Codable {
    let hero380_Image: URL?
    let linksSelf, client, reportAtAddress, jobCategory: String?
    let skills, appearances: String?

    enum CodingKeys: String, CodingKey {
        case hero380_Image = "hero_380_image"
        case linksSelf = "self"
        case client
        case reportAtAddress = "report_at_address"
        case jobCategory = "job_category"
        case skills, appearances
    }
}
