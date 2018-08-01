//
//  ExtensionHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 01/08/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func roundImageBorder(color : String, width: CGFloat){
        let v = self;
        v.layoutIfNeeded();
        v.layer.cornerRadius = v.frame.size.width/2;
        v.clipsToBounds = true;
        v.layer.borderColor = CSS.colorWithHexString(color).cgColor;
        v.layer.borderWidth = width;
    }
    
}

