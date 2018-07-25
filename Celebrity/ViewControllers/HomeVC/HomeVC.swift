//
//  HomeVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import SwiftIconFont

class HomeVC: UIViewController{
    
    
    
    
    override func viewDidLoad() {
        //
        
    }
    
    @IBAction func gotoSettings(_ sender: UIButton) {
        PageRedirect.redirectToSettingsPage(vc: self);
    }
    
    @IBAction func gotoElist(_ sender: UIButton) {
        PageRedirect.redirectToElistPage(vc: self, key: "users", obj: nil);
    }
    
    
    
}
