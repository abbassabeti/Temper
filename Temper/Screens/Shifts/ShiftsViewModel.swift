//
//  ShiftsViewModel.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import CoreLocation

class ShiftsViewModel {
    
    var disposeBag : DisposeBag
    
    var provider : RestApi?
    
    var shifts : BehaviorRelay<[ShiftsModel]> = .init(value: [])
    
    var error: BehaviorRelay<TemperError?> = .init(value: nil)
    
    var toastSrc : BehaviorRelay<String?> = .init(value: nil)
    
    var location: BehaviorRelay<CLLocation?>
    
    var lastRequestedDate : Date?
    
    var lastRefreshTime : Date

    init(shifts: [ShiftsModel], provider: RestApi,locationStatus: BehaviorRelay<CLLocation?>){
        self.shifts.accept(shifts)
        self.provider = provider
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag
        self.location = locationStatus
        self.lastRefreshTime = Date()
    }
    
    func loadMoreData(isReload: Bool = false) {
        var date = (shifts.value.last?.date ?? Date())
        if (isReload){
            date = Date()
        }else{
            date.changeDays(by: 1)
        }
        guard let provider = provider else {
            self.error.accept(TemperError(unexpected: true))
            return
        }
        if let lastRequestedDate = self.lastRequestedDate {
            guard date.compare(lastRequestedDate) == .orderedDescending else {return}
        }
        lastRequestedDate = date
        let refreshTime = self.lastRefreshTime
        provider.fetchShifts(date: date).asDriver(onErrorJustReturn: .failure(TemperError(unexpected: true))).drive(onNext: { (result) in
            guard refreshTime.distance(to: self.lastRefreshTime).isEqual(to: 0) else {return} //previous page loadings should be ignored after pull to refresh
            switch result {
                case .success(let model):
                    let data = model.items
                    let newModel = ShiftsModel(data: data,date: date)
                    var items = isReload ? [] : self.shifts.value
                    items.append(newModel)
                    self.shifts.accept(items)
                    guard newModel.items.count > 0 else {
                        self.loadMoreData()
                        return
                    }
                case .failure(let error):
                    self.lastRequestedDate = self.shifts.value.last?.date
                    self.error.accept(error)
            }
        }).disposed(by: disposeBag)
    }
    
    func provideDataSource(_ tableView: UITableView){
        let dataSource = RxTableViewSectionedAnimatedDataSource<ShiftsModel>(configureCell: { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else {return UITableViewCell()}
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShiftCell
            cell.configView(item: item, location: self.location)
            if indexPath.section == self.shifts.value.count - 1 && indexPath.row == self.shifts.value[indexPath.section].items.count - 1 {
                self.loadMoreData()
            }
            return cell
        })
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .bottom, reloadAnimation: .fade, deleteAnimation: .fade)
        dataSource.titleForHeaderInSection = { model, index in
            return model.sectionModels[index].date?.dateString(format: "EEEE dd MMMM")
        }
        
        tableView.rx.delegate.methodInvoked(#selector(tableView.delegate?.tableView(_:willDisplayHeaderView:forSection:)))
                    .takeUntil(tableView.rx.deallocated)
                    .subscribe(onNext: { event in
                        guard let headerView = event[1] as? UITableViewHeaderFooterView else { return }
                        
                        for view in headerView.subviews {
                            view.backgroundColor = .white
                        }
                        headerView.textLabel?.font = .systemFont(ofSize: 18).semibold
                        headerView.backgroundColor = .white
                        headerView.textLabel?.sizeToFit()
                    }).disposed(by: disposeBag)

        
        self.shifts.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by:disposeBag)
        self.loadMoreData()
    }
    
    func refreshList(){
        //self.shifts.accept([])
        self.lastRefreshTime = Date()
        loadMoreData(isReload: true)
    }
}
