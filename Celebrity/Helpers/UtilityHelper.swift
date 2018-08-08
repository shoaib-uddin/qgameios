//
//  UtilityHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 21/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import LKAlertController

class UtilityHelper{
    
    class func AlertMessage(_ msg: String) {
        Alert(title: nil, message: msg)
            .addAction("Ok")
            .show()
    }
    class func AlertMessage(title: String, _ msg: String) {
        Alert(title: title, message: msg)
            .addAction("Ok")
            .show()
    }
    
    
    class func AlertMessagewithCallBack(_ msg: String,  success: @escaping () -> Void) {
        Alert(title: nil, message: msg).addAction("OK", style: .default) { (_) -> Void in
            success();
            }.show();
    }
    
    
    class func AlertConfirm(_ msg: String,  success: @escaping () -> Void) {
        Alert(title: nil, message: msg).addAction("Confirm", style: .default) { (_) -> Void in
            success();
            }.addAction("Cancel").show();
    }
    
    class func AlertMessagewithTextFieldAndCallBack(placeholder: String, msg: String, success: @escaping (_ textValue : String) -> Void, Secure: Bool = false , _ textfieldtext: String  = "") {
        var textField = UITextField()   ;
        textField.placeholder = placeholder;
        textField.isSecureTextEntry = Secure;
        textField.text = textfieldtext;
        Alert(title: nil, message: msg).addTextField(&textField).addAction("OK", style: .default) { (alert) -> Void in            success(textField.text!);
            }.addAction("Cancel").show();
        
    }
    
    class func secIntoFormat(_ sec: Int) -> String{
        
        let interval = sec
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(interval))!
//        print(formattedString)
        return formattedString;
        
    }
    
    class func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
        let length = Int64(range.upperBound - range.lowerBound + 1)
        let value = Int64(arc4random()) % length + Int64(range.lowerBound)
        return T(value)
    }


    
}
