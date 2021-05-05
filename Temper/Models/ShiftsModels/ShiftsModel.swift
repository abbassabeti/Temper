//
//  MasterData.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import Foundation
import RxDataSources

// MARK: - MasterData
class ShiftsModel : Codable, AnimatableSectionModelType {
    
    required init(original: ShiftsModel, items: [ShiftItem]) {
        self.items = items
        self.date = original.date
    }
    
    
    typealias Item = ShiftItem
    
    var identity: Int{
        return Int(date?.timeIntervalSince1970.magnitude ?? 0)
    }
    
    var items: [ShiftItem]
    let date : Date?
    var isLoading: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case items = "data"
        case date
    }
    
    init(data: [ShiftItem],date: Date,loading: Bool = false){
        self.items = data
        self.date = date
        self.isLoading = loading
    }
}
