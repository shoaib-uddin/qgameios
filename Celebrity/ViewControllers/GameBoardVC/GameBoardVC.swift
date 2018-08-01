//
//  GameBoardVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 24/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData;

class GameBoardVC: UIViewController, UserTurnViewDelegate {
    
    
    @IBOutlet weak var parentVIew: UIView!
    var userTurnView: UserTurnView!;
    
    override func viewDidLoad() {
        //
        addView("turn");
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    func addView(_ v: String){
        
        let w = self.parentVIew.frame.width;
        let h = self.parentVIew.frame.height;
        
        switch v {
        case "turn":
            
            if(self.userTurnView == nil){
                self.userTurnView =  Bundle.main.loadNibNamed("UserTurnView", owner: self, options: nil)?[0] as! UserTurnView;
                self.userTurnView.frame = CGRect(x: 0, y: 0, width: w, height: h);
                self.userTurnView.delegate = self;
                self.userTurnView.tag = 80;
                self.parentVIew.addSubview(self.userTurnView)
            }
            self.parentVIew.bringSubview(toFront: self.userTurnView);
            
            break;
        default:
            break
        }
        
    }
    
    
    
    // delegates
    func SwitchPlayer(view: UserTurnView) {
        //
        
    }
    
    
}

