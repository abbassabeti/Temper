//
//  TemperError.swift
//  Temper
//
//  Created by Abbas on 5/1/21.
//

import Foundation

public struct TemperError: Codable {

    var code: Int?
    var message: String?

    init(code: Int?,message: String?) {
        self.code = code
        self.message = message
    }
    
    init(unexpected: Bool){
        self.code = -1
        self.message = "Unexpected Error"
    }
}

extension TemperError: Error{
    
}
