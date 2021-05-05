//
//  Alert.swift
//  Temper
//
//  Created by Abbas on 5/1/21.
//

import UIKit
import Toast_Swift

extension UIViewController {
    func showAlert(title: String = "Error",message: String, style: UIAlertController.Style = .alert,actionTitle: String = "Ok",action: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: action))
        self.present(alert, animated: true, completion: nil)
    }
    
    func toast(_ value: String,position: ToastPosition = .center){
        self.view.makeToast(value, position: position)
    }
}
