//
//  Date.swift
//  Temper
//
//  Created by Abbas on 5/1/21.
//

import Foundation
import CodableWrappers

/*
 + (NSString *) greDateToGreString:(NSDate *) date withFromat:(NSString *) format
 {
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:format];
     [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:
                             NSCalendarIdentifierGregorian]
      ];
     formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];

     NSString *stringFromDate = [formatter stringFromDate:date];
     
     return stringFromDate;

 }

 */


extension Date {
    func dateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: self)
    }
    mutating func changeDays(by days: Int) {
        self = Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

// Custom coder
@available(macOS 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public struct FractionalSecondsISO8601DateStaticCoder: StaticCoder {

    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFractionalSeconds
        return formatter
    }()

    public static func decode(from decoder: Decoder) throws -> Date? {
        let stringValue = try String(from: decoder)
        guard let date = iso8601Formatter.date(from: stringValue) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected date string to be ISO8601-formatted."))
        }
        return date
    }

    public static func encode(value: Date?, to encoder: Encoder) throws {
        guard let val = value else {return}
        try iso8601Formatter.string(from: val).encode(to: encoder)
    }
}
// Property Wrapper alias
public typealias ISO8601FractionalDateCoding = CodingUses<FractionalSecondsISO8601DateStaticCoder>
