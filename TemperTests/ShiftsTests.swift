//
//  TemperTests.swift
//  TemperTests
//
//  Created by Abbas on 5/1/21.
//

import XCTest
import CoreLocation
import RxSwift
import RxRelay
@testable import Temper

class ShiftsTests: XCTestCase {
    
    var shiftViewModel : ShiftsViewModel!
    var provider : RestApi!
    var locations : BehaviorRelay<CLLocation?>!
    var toast : BehaviorRelay<String?>!
    var error : BehaviorRelay<TemperError?>!
    var disposeBag : DisposeBag!

    override func setUpWithError() throws {
        let provider = RestApi(provider: TemperNetworking.stubbingTemperNetworking())
        let locations = BehaviorRelay<CLLocation?>(value: nil)
        let shiftViewModel = ShiftsViewModel(shifts: [], provider: provider, locationStatus: locations)
        
        self.shiftViewModel = shiftViewModel
        self.provider = provider
        self.locations = locations
        
        let toast = BehaviorRelay<String?>(value: nil)
        let error = BehaviorRelay<TemperError?>(value: nil)
        self.toast = toast
        self.error = error
        
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag
        
        shiftViewModel.error.asDriver().drive(error).disposed(by: disposeBag)
        shiftViewModel.toastSrc.asDriver().drive(toast).disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
    }

    func testListLoadAndReload() throws {
        let firstCount = shiftViewModel.shifts.value.count
        shiftViewModel.loadMoreData(isReload: false)
        sleep(1)
        let secondCount = shiftViewModel.shifts.value.count
        shiftViewModel.loadMoreData(isReload: false)
        sleep(1)
        let thirdCount = shiftViewModel.shifts.value.count
        shiftViewModel.refreshList()
        sleep(1)
        let fourthCount = shiftViewModel.shifts.value.count
        
        XCTAssert(firstCount < secondCount, "Second fetch was unsuccessful \(firstCount) vs \(secondCount)")
        XCTAssert(secondCount < thirdCount, "Third fetch was unsuccessful \(secondCount) vs \(thirdCount)")
        XCTAssert(thirdCount > fourthCount, "Fourth fetch was unsuccessful \(thirdCount) vs \(fourthCount)")
    }
    
    func testRecurringRefreshes() throws {
        for _ in 1...20{
            shiftViewModel.refreshList()
        }
        sleep(1)
        let itemCount = shiftViewModel.shifts.value.count
        XCTAssert(itemCount == 1, "Refreshing list issues")
    }
    
    func testToastAndErrorRelays() throws {
        let testMessage = "TestMessage"
        let errorMessage = "TestError"
        shiftViewModel.toastSrc.accept(testMessage)
        shiftViewModel.error.accept(TemperError.init(code: 121, message: errorMessage))
        sleep(1)
        XCTAssert(toast.value == testMessage, "Problem with toast Relay")
        XCTAssert(error.value?.message == errorMessage && error.value?.code == 121, "Problem with error Relay")
        
        
        let testMessage2 = "TestMessage2"
        let errorMessage2 = "TestError2"
        shiftViewModel.toastSrc.accept(testMessage2)
        shiftViewModel.error.accept(TemperError.init(code: 122, message: errorMessage2))
        sleep(1)
        XCTAssert(toast.value == testMessage2, "Problem with toast Relay")
        XCTAssert(error.value?.message == errorMessage2 && error.value?.code == 122, "Problem with error Relay")
    }

}
