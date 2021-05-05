//
//  ShiftCell.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import Kingfisher
import SnapKit
import CoreLocation
import RxSwift
import RxRelay

class ShiftCell : UITableViewCell {
    
    var imgView : UIImageView?
    var nameLbl: UILabel?
    var priceLbl : CurvyLabel?
    var addressLbl : UILabel?
    var timeLbl : UILabel?
    var item : ShiftItem?
    var initializedLoc : Bool = false
    
    var disposeBag : DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.addressLbl?.text = nil
        self.priceLbl?.text = nil
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
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(priceLbl)
        self.contentView.addSubview(addressLbl)
        self.contentView.addSubview(timeLabel)
        
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
        self.selectionStyle = .none

        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(8)
            make.height.equalTo(240)
            make.leading.equalTo(self.contentView).offset(16)
            make.trailing.equalTo(self.contentView).offset(-16)
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
            make.bottom.equalTo(self.contentView).offset(-8)
            make.height.greaterThanOrEqualTo(20)
        }
        
        priceLbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgView.snp.bottom)
            make.trailing.equalTo(imgView.snp.trailing)
            make.leading.greaterThanOrEqualTo(imgView.snp.leading)
        }
    }
    
    func configView(item: ShiftItem,location: BehaviorRelay<CLLocation?>){
        self.item = item
        self.setLocationRelayIfNeeded(relay: location)
        self.setCategoryWithAddress(location: location.value)
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
            if let jobLoc = item?.job?.reportAtAddress?.geo.getLocation() {
                let distance = String(format: "%d km",Int(jobLoc.distance(from: ourLoc).magnitude / 1000))
                values.append(distance)
            }
        }
        let output = values.joined(separator: " - ")
        
        self.addressLbl?.text = output
        self.addressLbl?.sizeToFit()
    }
}
