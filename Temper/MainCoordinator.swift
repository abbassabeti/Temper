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
    
    func openDummyVC(_ title: String) {
        let vc = UIViewController()
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
