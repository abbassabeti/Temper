//
//  OverlayButtons.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class StackButtons : TemperView {
    var buttons : [UIButton]
    var stackView : UIStackView
    var disposeBag : DisposeBag
    var hasDelimitter : Bool
    var isOverlay : Bool
    
    override init(frame: CGRect) {
        self.buttons = []
        self.stackView = UIStackView()
        self.disposeBag = DisposeBag()
        self.hasDelimitter = true
        self.isOverlay = true
        super.init(frame: frame)
        configView()
    }
    
    init(hasDelimitter: Bool,isOverlay: Bool){
        self.buttons = []
        self.stackView = UIStackView()
        self.disposeBag = DisposeBag()
        self.hasDelimitter = hasDelimitter
        self.isOverlay = isOverlay
        super.init(frame: CGRect())
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (isOverlay){
            self.defineShadow()
            self.cornerRadius = self.frame.height / 2
        }
    }
    
    func configView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        if (self.isOverlay){
            stackView.spacing = 0
            self.cornerRadius = self.frame.height / 2
        }else{
            stackView.spacing = 20
        }
        self.layer.masksToBounds = true
        self.clipsToBounds  = true
        self.backgroundColor = .white
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(isOverlay ? 0 : 8)
            make.left.equalToSuperview().offset(isOverlay ? 0 : 16)
            make.right.equalToSuperview().offset(isOverlay ? 0 : -16)
            make.bottom.equalToSuperview().offset(isOverlay ? 0 : -8)
        }
    }
    
    func addButtons(buttons: [StackButtonItemModel]){
        self.buttons = []
        let count = buttons.count
        let pixelOffset = hasDelimitter ? (count - 1) * -1 : (isOverlay ? 0 : -20)
        for (index,btnModel) in buttons.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.black, for: .normal)
            button.setTitle(btnModel.name, for: .normal)
            button.setImage(btnModel.icon, for: .normal)
            if let borderWidth = btnModel.borderWidth {
                button.layer.borderWidth = borderWidth
                button.layer.borderColor = btnModel.borderColor?.cgColor
            }
            button.backgroundColor = btnModel.backgroundColor
            if let cornerRadius = btnModel.cornerRadius {
                button.layer.cornerRadius = cornerRadius
                button.clipsToBounds = true
            }
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
            button.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
            button.rx.tap.subscribe { event in
                btnModel.action(btnModel.name)
            }.disposed(by: self.disposeBag)
            self.stackView.addArrangedSubview(button)
            //if (isOverlay){
                button.snp.makeConstraints { make in
                    make.width.equalTo(self).offset(pixelOffset).dividedBy(count)
                }
            //}
            if hasDelimitter && buttons.count - 1 > index {
                self.stackView.addArrangedSubview(DelimitterView())
            }
            self.buttons.append(button)
        }
    }
}
