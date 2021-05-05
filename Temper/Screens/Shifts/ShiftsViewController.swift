//
//  ShiftsViewController.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import SnapKit
import RxSwift
import Toast_Swift

class ShiftsViewController : TemperViewController {
    var viewModel : ShiftsViewModel?
    var tableView : UITableView?
    var disposeBag : DisposeBag?
    
    weak var coordinator : MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupView(){
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag
        self.view.backgroundColor = .white
        
        configTableView()
        
        self.configOverlayView(action: self.openDummyVC)
        self.configBottomView(action: self.openDummyVC)

        self.viewModel?.shifts.subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.tableView?.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
        
        self.viewModel?.error.subscribe(onNext: {[weak self] error in
            guard let self = self, let message = error?.message else {return}
            self.showAlert(message: message)
        }).disposed(by: disposeBag)
        
        self.viewModel?.toastSrc.subscribe(onNext: {[weak self] value in
            guard let self = self, let value = value else {return}
            self.toast(value)
        }).disposed(by: disposeBag)
    }
    
    func openDummyVC(_ title: String){
        coordinator?.openDummyVC(source: self, title)
    }
    
    func reloadTableView(){
        guard let tableView = self.tableView else {return}
        tableView.reloadData()
    }
    
    func configTableView(){
        let tableView = UITableView()
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-1 * bottomActionsHeight)
            make.left.right.equalTo(self.view)
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ShiftCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.separatorStyle = .none
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.viewModel?.provideDataSource(tableView)
        refreshControl.beginRefreshing()
    }
    
    @objc func pullToRefresh(){
        viewModel?.refreshList()
        self.tableView?.refreshControl?.endRefreshing()
    }
}
