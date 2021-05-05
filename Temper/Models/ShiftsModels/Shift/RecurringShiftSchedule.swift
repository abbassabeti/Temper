//
//  RecurringShiftSchedule.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import Foundation

struct RecurringShiftSchedule: Codable {
    let id: String?
    let tempersNeeded: Int?
    let earningsPerHour: PerHour?
    let totalCostPerHour: PerHour?
    @TimeStringHybridCoding
    var startsAt: String?
    @TimeStringHybridCoding
    var endsAt: String?
    let monday, tuesday, wednesday, thursday: Bool?
    let friday, saturday, sunday: Bool?
    let scheduleStartDate, scheduleEndDate: String?
    let isActive, variablePricing, commitmentPreferred: Bool?
    let cancellationPolicy: Int?
    let shiftGroupID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tempersNeeded = "tempers_needed"
        case earningsPerHour = "earnings_per_hour"
        case totalCostPerHour = "total_cost_per_hour"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
        case scheduleStartDate = "schedule_start_date"
        case scheduleEndDate = "schedule_end_date"
        case isActive = "is_active"
        case variablePricing = "variable_pricing"
        case commitmentPreferred = "commitment_preferred"
        case cancellationPolicy = "cancellation_policy"
        case shiftGroupID = "shift_group_id"
    }
}
