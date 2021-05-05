//
//  Client.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation

// MARK: - Client
struct Client: Codable {
    let id, name, slug, registrationName: String?
    let registrationID, clientDescription: String?
    let allowTemperTrial: Bool?
    let links: ClientLinks?
    let rating: Rating?
    let averageResponseTime: Double?
    let factoringAllowed: Bool?
    let factoringPaymentTermInDays: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case registrationName = "registration_name"
        case registrationID = "registration_id"
        case clientDescription = "description"
        case allowTemperTrial = "allow_temper_trial"
        case links, rating
        case averageResponseTime = "average_response_time"
        case factoringAllowed = "factoring_allowed"
        case factoringPaymentTermInDays = "factoring_payment_term_in_days"
    }
}
