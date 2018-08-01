//
//  CSSHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

class CSS{
    
    class func colorWithHexString (_ hex:String) -> UIColor {
        
        var cString:String = hex.uppercased();
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func setFontImageVisualsMaterial(_ v: UIImageView, name: String, color: String){
        
        let clr = self.colorWithHexString(color);
        let imSIze = CGSize(width: v.frame.width, height: v.frame.width);
        v.setIcon(from: .MaterialIcon, code: name, textColor: clr, backgroundColor: .clear, size: imSIze);
        
    }
    
    class func setFontImageVisualsFontAwesome(_ v: UIImageView, name: String, color: String){
        
        let clr = self.colorWithHexString(color);
        let imSIze = CGSize(width: v.frame.width, height: v.frame.width);
        v.setIcon(from: .FontAwesome, code: name, textColor: clr, backgroundColor: .clear, size: imSIze);
        
    }

    
}

