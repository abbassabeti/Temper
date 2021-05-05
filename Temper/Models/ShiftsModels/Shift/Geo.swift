//
//  Geo.swift
//  Temper
//
//  Created by Abbas on 5/4/21.
//

import Foundation
import CoreLocation

// MARK: - Geo
struct Geo: Codable {
    let lat, lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
    
    func getLocation() -> CLLocation? {
        guard let lat = lat, let lon = lon else {return nil}
        return CLLocation(latitude: lat, longitude: lon)
    }
}
