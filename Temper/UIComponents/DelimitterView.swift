//
//  DelimitterView.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit
import SnapKit

class DelimitterView : UIView {
    
    var isHorizontal: Bool = false{
        didSet{
            setupView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .delimitterColor
        if isHorizontal {
            self.snp.removeConstraints()
            self.snp.makeConstraints { make in
                make.height.equalTo(1)
            }
        }else{
            self.snp.removeConstraints()
            self.snp.makeConstraints { make in
                make.width.equalTo(1)
            }
        }
    }
}
