//
//  PerHour.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import Foundation

// MARK: - PerHour
struct PerHour: Codable {
    let currency: Currency?
    @DoubleStringHybridCoding
    var amount: Double?
    
    func getWage() -> String{
        guard let currency = self.currency else {return ""}
        guard let amount = self.amount else {return ""}
        return "\(amount) \(currency)"
    }
}
