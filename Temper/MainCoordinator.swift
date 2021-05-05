//
//  MainCoordinator.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import RxSwift
import RxRelay
import CoreLocation

class MainCoordinator : NSObject {
    
    var provider: RestApi = RestApi(provider: TemperNetworking.temperNetworking())
    let locationManager = CLLocationManager()
    
    var locationStatus = BehaviorRelay<CLLocation?>(value: nil)

    var navigationController : UINavigationController?

    let disposeBag = DisposeBag()
    
    override init(){
        super.init()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
    }
    
    func provideShiftsViewModel() -> ShiftsViewModel{
        let viewModel = ShiftsViewModel(shifts: [],provider: provider,locationStatus: locationStatus)
        return viewModel
    }
    
    func provideMapViewModel(shifts: [ShiftsModel]) -> MapViewModel {
        let items = shifts.flatMap({$0.items}).map({MarkerItem(from: $0)}).compactMap({$0})
        return MapViewModel(markers: items,location: self.locationStatus)
    }
    
    func provideShiftsViewController () -> ShiftsViewController {
        let shiftsVC = ShiftsViewController()
        shiftsVC.coordinator = self
        shiftsVC.viewModel = self.provideShiftsViewModel()
        return shiftsVC
    }
    
    func provideShiftNavigationController() -> UINavigationController {
        let shiftsVC = provideShiftsViewController()
        let navVC = UINavigationController(rootViewController: shiftsVC)
        self.navigationController = navVC
        
        return navVC
    }
    
    func openDummyVC(source: TemperViewController,_ title: String) {
        var vc: UIViewController
        switch title {
            case "Kaart":
                let mapVC = MapViewController()
                let shiftsModel = (source as? ShiftsViewController)?.viewModel?.shifts.value ?? []
                mapVC.viewModel = provideMapViewModel(shifts: shiftsModel)
                vc = mapVC
            default:
                vc = UIViewController()
        }
        vc.title = title
        vc.view.backgroundColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainCoordinator : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        locationStatus.accept(location)
    }
}
