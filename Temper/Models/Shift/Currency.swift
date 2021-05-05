//
//  Currency.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import Foundation

enum Currency : String,Codable {
    case euro = "EUR"
    case other
    
    func getSign() -> String{
        switch self {
            case .euro :
                return "€"
            default:
                return self.rawValue
        }
    }
}
