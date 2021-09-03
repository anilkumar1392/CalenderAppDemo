//
//  AlertController.swift
//  Demo1
//
//  Created by mac on 31/05/21.
//

import Foundation
import UIKit

class AlertController {
    
    static let shared = AlertController()
    var alert : UIAlertController? = nil
    
    fileprivate func topMostController() -> UIViewController? {
        var presentedVC = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
        }
        return presentedVC
    }
    
    class func showAlert(message : String) {
        shared.alert = UIAlertController(title: kMessage, message: message, preferredStyle: .alert)
        shared.topMostController()?.present(shared.alert ?? UIAlertController(), animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            shared.alert?.dismiss(animated: true, completion: nil)
        }
    }
    
}
