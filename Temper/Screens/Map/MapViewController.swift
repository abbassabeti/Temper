//
//  MapViewController.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class MapViewController : TemperViewController {
    
    var mapView: MKMapView?
    var shiftView: ShiftView?
    var disposeBag : DisposeBag?
    var viewModel: MapViewModel?
    
    weak var coordinator : MainCoordinator?
    
    var isDescriptionExpanded : Bool = false {
        didSet{
            let expand = isDescriptionExpanded
            UIView.animate(withDuration: 0.5) {[weak self] in
                guard let self = self else {return}
                self.shiftView?.snp.updateConstraints({[weak self] make in
                    guard let self = self else {return}
                    if (expand){
                        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                    }else{
                        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(self.view.frame.height / 2)
                    }
                })
                self.shiftView?.alpha = expand ? 1 : 0
                self.shiftView?.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        let mapView = MKMapView()
        self.mapView = mapView
        
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.left.bottom.equalToSuperview()
        }
        let shiftView = ShiftView()
        self.shiftView = shiftView
        shiftView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(shiftView)
        shiftView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(self.view.frame.height / 2)
        }
        
        self.viewModel?.markers.subscribe(onNext: { items in
            mapView.annotations.forEach { oldItem in
                mapView.removeAnnotation(oldItem)
            }
            items.forEach({mapView.addAnnotation($0)})
            mapView.fitMapViewToAnnotationList()
        }).disposed(by: disposeBag)
        
        self.viewModel?.shiftItem.subscribe(onNext: {[weak self] item in
            guard let self = self else {return}
            guard let shiftItem = item else {return}
            shiftView.configView(item: shiftItem, location: self.viewModel?.location)
        }).disposed(by: disposeBag)
        
        mapView.delegate = self
    }
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel?.provideProperShift(for: view)
        self.isDescriptionExpanded = true
        if let coor = view.annotation?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.isDescriptionExpanded = false
    }
}
