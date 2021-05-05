//
//  StringsExtensions.swift
//  PokemonSDK
//
//  Created by Abbas on 1/6/21.
//

import Foundation
import CodableWrappers

extension String {
    var url : URL? {
        get {
            return URL(string: self)
        }
    }
    
    var djb2hash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}

@available(macOS 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public struct DoubleStringHybridStaticCoder: StaticCoder {
    
    public static func decode(from decoder: Decoder) throws -> Double? {
        guard let value = try? String(from: decoder) else {
            guard let value = try? Double(from: decoder) else {
                return nil
            }
            return value
        }
        return Double(value)
    }
    
    public static func encode(value: Double?, to encoder: Encoder) throws {
        guard let val = value else {return}
        var container = encoder.singleValueContainer()
        try container.encode(val)
    }
}

public typealias DoubleStringHybridCoding = CodingUses<DoubleStringHybridStaticCoder>

@available(macOS 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public struct TimeStringHybridStaticCoder: StaticCoder {
    
    
    private static let decodeFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private static let encodeFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    public static func decode(from decoder: Decoder) throws -> String? {
        guard let value = try? String(from: decoder) else {
            return nil
        }
        guard let result = decodeFormatter.date(from: value)?.dateString(format: "HH:mm") else {return nil}
        return result
    }
    
    public static func encode(value: String?, to encoder: Encoder) throws {
        guard let val = value else {return}
        var container = encoder.singleValueContainer()
        try container.encode(val)
    }
}

public typealias TimeStringHybridCoding = CodingUses<TimeStringHybridStaticCoder>
