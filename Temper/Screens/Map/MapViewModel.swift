//
//  MapViewModel.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import Foundation
import RxSwift
import RxRelay
import MapKit

class MapViewModel {
    var disposeBag : DisposeBag
    
    var markers : BehaviorRelay<[MarkerItem]> = .init(value: [])
    var shiftItem : BehaviorRelay<ShiftItem?> = .init(value: nil)
    var location: BehaviorRelay<CLLocation?>

    
    init(markers: [MarkerItem],location: BehaviorRelay<CLLocation?>){
        self.markers.accept(markers)
        self.location = location
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag
    }
    
    func provideProperShift(for view: MKAnnotationView){
        guard let item = view.annotation as? MarkerItem else {return}
        self.shiftItem.accept(item.info)
    }
}
