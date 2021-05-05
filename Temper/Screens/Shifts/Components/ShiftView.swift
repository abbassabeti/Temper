//
//  ShiftView.swift
//  Temper
//
//  Created by Abbas on 5/6/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import Kingfisher
import CoreLocation

class ShiftView : UIView {
    
    var imgView : UIImageView?
    var nameLbl: UILabel?
    var priceLbl : CurvyLabel?
    var addressLbl : UILabel?
    var timeLbl : UILabel?
    var item : ShiftItem?
    var initializedLoc : Bool = false
    
    var disposeBag : DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setLocationRelayIfNeeded(relay: BehaviorRelay<CLLocation?>) {
        guard !initializedLoc else {return}
        relay.subscribe (onNext:{[weak self] loc in
            guard let self = self else {return}
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.setCategoryWithAddress(location: loc)
            }
        }).disposed(by: disposeBag)
        initializedLoc = true

    }
    
    func clearView() {
        self.addressLbl?.text = nil
        self.priceLbl?.text = "-"
        self.nameLbl?.text = nil
        self.timeLbl?.text = nil
        self.imgView?.image = nil
        self.item = nil
    }
    func setupView(){
        let imgView = UIImageView()
        let nameLbl = UILabel()
        let priceLbl = CurvyLabel()
        let addressLbl = UILabel()
        let timeLabel = UILabel()
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        addressLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imgView)
        self.addSubview(nameLbl)
        self.addSubview(priceLbl)
        self.addSubview(addressLbl)
        self.addSubview(timeLabel)
        
        self.imgView = imgView
        self.nameLbl = nameLbl
        self.priceLbl = priceLbl
        self.addressLbl = addressLbl
        self.timeLbl = timeLabel
        
        nameLbl.numberOfLines = 0
        priceLbl.numberOfLines = 1
        addressLbl.numberOfLines = 0
        timeLabel.numberOfLines = 0
        nameLbl.textAlignment = .left
        priceLbl.textAlignment = .right
        priceLbl.backgroundColor = .white
        addressLbl.textColor = .addressLabel
        priceLbl.leftInset = 25
        priceLbl.bottomInset = 0
        priceLbl.font = UIFont.boldSystemFont(ofSize: 17)
        addressLbl.textAlignment = .left
        imgView.contentMode = .scaleAspectFill
        addressLbl.font = UIFont.boldSystemFont(ofSize: 13)
        nameLbl.font = UIFont.boldSystemFont(ofSize: 17)
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        imgView.layer.cornerRadius = 23
        imgView.layer.masksToBounds = true
        imgView.backgroundColor = .gray
        self.backgroundColor = .white

        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(240)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addressLbl.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(8)
            make.leading.equalTo(imgView.snp.leading)
            make.trailing.equalTo(imgView.snp.trailing)
            make.height.greaterThanOrEqualTo(20)
        }
        
        nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(addressLbl.snp.bottom).offset(8)
            make.leading.equalTo(imgView.snp.leading)
            make.trailing.equalTo(imgView.snp.trailing)
            make.height.greaterThanOrEqualTo(20)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLbl.snp.bottom).offset(8)
            make.leading.equalTo(imgView.snp.leading)
            make.trailing.equalTo(imgView.snp.trailing)
            make.bottom.equalToSuperview().offset(-8)
            make.height.greaterThanOrEqualTo(20)
        }
        
        priceLbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgView.snp.bottom)
            make.trailing.equalTo(imgView.snp.trailing)
            make.leading.greaterThanOrEqualTo(imgView.snp.leading)
            make.width.greaterThanOrEqualTo(60)
            make.height.greaterThanOrEqualTo(22)
        }
    }
    
    func configView(item: ShiftItem,location: BehaviorRelay<CLLocation?>?){
        self.item = item
        if let location = location {
            self.setLocationRelayIfNeeded(relay: location)
            self.setCategoryWithAddress(location: location.value)
        }
        self.priceLbl?.text = item.getWage()
        self.imgView?.kf.setImage(with: item.getImageURL())
        self.priceLbl?.text = item.getPrice()
        self.nameLbl?.text = item.getJobTitle()
        self.timeLbl?.text = item.getDurationString()
        self.priceLbl?.sizeToFit()
        self.addressLbl?.sizeToFit()
        self.nameLbl?.sizeToFit()
        self.timeLbl?.sizeToFit()
    }
    
    func setCategoryWithAddress(location: CLLocation?) {
        
        var values : [String] = []
        guard let category = item?.getCategory() else{
            return
        }
        values.append(category)
        if let ourLoc = location {
            if let jobLoc = item?.getLocation() {
                let distance = String(format: "%d km",Int(jobLoc.distance(from: ourLoc).magnitude / 1000))
                values.append(distance)
            }
        }
        let output = values.joined(separator: " - ")
        
        self.addressLbl?.text = output
        self.addressLbl?.sizeToFit()
    }
}
