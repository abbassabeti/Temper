//
//  TemperViewController.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import UIKit

class TemperViewController : UIViewController {
    
    let overlayHeight : CGFloat = 45
    let overlayOffset : CGFloat = -120
    let bottomActionsHeight : CGFloat = 60
    
    func configOverlayView(action : @escaping (String)->()){
        let buttons : [StackButtonItemModel] = [
            .init(icon: .init(named: "marker"), name: "Kaart", action: action),
            .init(icon: .init(named: "filter"), name: "Filters", action: action)
        ]
        let overlayButtons = StackButtons(hasDelimitter: true, isOverlay: true)
        self.view.addSubview(overlayButtons)
        overlayButtons.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(overlayOffset)
            make.width.equalToSuperview().dividedBy(1.7)
            make.height.equalTo(overlayHeight)
        }
        overlayButtons.addButtons(buttons: buttons)
    }
    
    func configBottomView(action : @escaping (String)->()){
        let buttons : [StackButtonItemModel] = [
            .init(icon: nil, name: "Sign up", action: action,backgroundColor: .temperGreen,cornerRadius: 8,borderWidth: nil,borderColor: nil),
            .init(icon: nil, name: "Log in", action: action,backgroundColor: .white,cornerRadius: 8,borderWidth: 1,borderColor: .black)
        ]
        let overlayButtons = StackButtons(hasDelimitter: false, isOverlay: false)
        overlayButtons.isOverlay = false
        overlayButtons.hasDelimitter = false
        self.view.addSubview(overlayButtons)
        overlayButtons.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(bottomActionsHeight)
        }
        overlayButtons.addButtons(buttons: buttons)
    }
}


