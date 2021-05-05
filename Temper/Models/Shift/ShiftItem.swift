//
//  ShiftItem.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import Foundation
import RxDataSources

// MARK: - ShiftItem
struct ShiftItem: Codable, IdentifiableType {
    
    typealias Identity = Int
    
    var identity: Int {
        return id?.djb2hash ?? 0
    }
    let id : String?
    let status: String?
    @ISO8601FractionalDateCoding
    var startsAt: Date?
    @ISO8601FractionalDateCoding
    var endsAt: Date?
    let duration, tempersNeeded: Int?
    let enableAutoAcceptRecentFreelancers: Bool?
    let cancellationPolicy: Int?
    @ISO8601FractionalDateCoding
    var createdAt: Date?
    let earningsPerHour: PerHour?
    let variablePricing, factoringAllowed, isFlexible: Bool?
    let timeVariationMessage: String?
    let startTimeEarlierVariation, startTimeLaterVariation, endTimeEarlierVariation, endTimeLaterVariation: Int?
    
    @ISO8601FractionalDateCoding
    var earliestPossibleStartTime: Date?
    
    @ISO8601FractionalDateCoding
    var latestPossibleEndTime: Date?
    let links: ShiftLinks?
    let openPositions, highChanceScore, applicationsCount: Int?
    let flexpools: [JSONAny]?
    let job: Job?
    let hasSubstitutedOpenings: Bool?
    let isAutoAcceptedWhenApplied, chanceOfSuccess: Bool?
    let recurringShiftSchedule: RecurringShiftSchedule?

    enum CodingKeys: String, CodingKey {
        case id,status
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case duration
        case tempersNeeded = "tempers_needed"
        case enableAutoAcceptRecentFreelancers = "enable_auto_accept_recent_freelancers"
        case cancellationPolicy = "cancellation_policy"
        case createdAt = "created_at"
        case earningsPerHour = "earnings_per_hour"
        case variablePricing = "variable_pricing"
        case factoringAllowed = "factoring_allowed"
        case isFlexible = "is_flexible"
        case timeVariationMessage = "time_variation_message"
        case startTimeEarlierVariation = "start_time_earlier_variation"
        case startTimeLaterVariation = "start_time_later_variation"
        case endTimeEarlierVariation = "end_time_earlier_variation"
        case endTimeLaterVariation = "end_time_later_variation"
        case earliestPossibleStartTime = "earliest_possible_start_time"
        case latestPossibleEndTime = "latest_possible_end_time"
        case links
        case openPositions = "open_positions"
        case highChanceScore = "high_chance_score"
        case applicationsCount = "applications_count"
        case flexpools, job
        case hasSubstitutedOpenings = "has_substituted_openings"
        case isAutoAcceptedWhenApplied = "is_auto_accepted_when_applied"
        case chanceOfSuccess = "chance_of_success"
        case recurringShiftSchedule = "recurring_shift_schedule"
    }
    
    func getImageURL()-> URL? {
        return self.job?.links?.hero380_Image ?? self.job?.project?.client?.links?.heroImage
    }
    
    func getDurationString() -> String? {
        return [recurringShiftSchedule?.startsAt,recurringShiftSchedule?.endsAt].compactMap({$0}).joined(separator: " - ")
    }
    
    func getPrice() -> String? {
        if let earning = self.earningsPerHour {
            if let amount = earning.amount {
                if let currency = earning.currency?.getSign() {
                    return String(format: "%@ %.2f", currency,amount)
                }
            }
        }
        return nil
    }
    
    func getCategory() -> String? {
        return self.job?.category?.nameTranslation?.enGB ?? self.job?.category?.name
    }
    
    func getJobTitle() -> String? {
        return self.job?.title
    }
    
    func getWage() -> String? {
        return self.earningsPerHour?.getWage()
    }
}

extension ShiftItem : Equatable {
    static func == (lhs: ShiftItem, rhs: ShiftItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}
