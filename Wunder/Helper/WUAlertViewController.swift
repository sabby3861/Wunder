//
//  WUAlertViewController.swift
//
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

protocol WUAlertDelegate {
    func alert(buttonClickedIndex:Int, buttonTitle: String, tag: Int)
}

class WUAlertViewController: NSObject {

    class func showAlert(withTitle title: String, message:String, buttons:[String] = ["Ok"], delegate:WUAlertDelegate? = nil, tag: Int = 0){
        
        var presentingViewController = UIApplication.shared.keyWindow?.rootViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tag = tag
        var index = 0
        for button in buttons {
           let action =  UIAlertAction(title: button, style: .default, handler: { (alertAction) in
            
            if let d = delegate{
                d.alert(buttonClickedIndex: index, buttonTitle: alertAction.title!, tag: tag)
            }
            })
            alert.addAction(action)
            index = index + 1
        }
       
        while presentingViewController?.presentedViewController != nil {
            presentingViewController = presentingViewController?.presentedViewController
        }
        
        presentingViewController?.present(alert, animated: true, completion: nil)
    }
}
