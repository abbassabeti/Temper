//
//  MarkerItem.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import Foundation
import MapKit

class MarkerItem: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: ShiftItem

    init(title: String, coordinate: CLLocationCoordinate2D, info: ShiftItem) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    convenience init?(from: ShiftItem){
        let title = from.getJobTitle() ?? from.getCategory() ?? ""
        guard let coordinate = from.getLocation()?.coordinate else {
            return nil
        }
        let info = from
        self.init(title: title,coordinate: coordinate,info: info)
    }
}
