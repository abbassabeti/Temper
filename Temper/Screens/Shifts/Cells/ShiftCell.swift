//
//  ShiftCell.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//

import UIKit
import SnapKit
import CoreLocation
import RxRelay

class ShiftCell : UITableViewCell {
    
    var shiftView : ShiftView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.shiftView?.clearView()
    }
    
    func setupView(){
        let shiftView = ShiftView()
        self.shiftView = shiftView
        shiftView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(shiftView)
        shiftView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        self.selectionStyle = .none
    }
    
    func configView(item: ShiftItem, location: BehaviorRelay<CLLocation?>){
        self.shiftView?.configView(item: item, location: location)
    }
}
