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

class GameBoardVC: UIViewController, UserTurnViewDelegate, AnsCountViewDelegate, TeamResultViewDelegate {
    
    
    
    
    @IBOutlet weak var parentVIew: UIView!
    var users: [Users] = [Users]();
    var userTurnView: UserTurnView!;
    var ansCountView: AnsCountView!;
    var teamResultView: TeamResultView!;
    var setIndex: Int = 0
    
    
    override func viewDidLoad() {
        //
        fetchallusers();
        addView("turn", setIndex);
//        addView("result", setIndex);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func fetchallusers(){
        UserDataHelper.setAllUsersCounterToZero();
        users = UserDataHelper.getAllUsers() as! [Users];
    }
    
    
    
    func addView(_ v: String, _ index: Int){
        
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
            self.userTurnView.setData(users[index])
            //self.parentVIew.bringSubview(toFront: self.userTurnView);
            
            
            break;
        case "result":
            
            if(self.teamResultView == nil){
                self.teamResultView =  Bundle.main.loadNibNamed("TeamResultView", owner: self, options: nil)?[0] as! TeamResultView;
                self.teamResultView.frame = CGRect(x: 0, y: 0, width: w, height: h);
                self.teamResultView.delegate = self;
                self.teamResultView.tag = 84;
                self.parentVIew.addSubview(self.teamResultView)
            }
            self.teamResultView.setData();
            
            
            
        default:
            break
        }
        
    }
    
    
    
    // delegates
    func SwitchPlayer(view: UserTurnView, user: Users, write: [Celeb], wrong: [Celeb]) {
        //

        self.userTurnView.removeFromSuperview();
        self.userTurnView = nil;
//        //view.removeFromSuperview();
        let w = self.parentVIew.frame.width;
        let h = self.parentVIew.frame.height;

        if(self.ansCountView == nil){
            self.ansCountView =  Bundle.main.loadNibNamed("AnsCountView", owner: self, options: nil)?[0] as! AnsCountView;
            self.ansCountView.frame = CGRect(x: 0, y: 0, width: w, height: h);
            self.ansCountView.delegate = self;
            self.ansCountView.tag = 82;
         
            self.parentVIew.addSubview(self.ansCountView)
        }
        self.ansCountView.setData(user: user, write: write, wrong: wrong)

        //self.parentVIew.bringSubview(toFront: self.ansCountView);
        
    }
    
    // delegate
    func SwitchView(view: AnsCountView) {
        //
        
        self.ansCountView.removeFromSuperview();
        self.ansCountView = nil
        setIndex = setIndex + 1;
        if(setIndex >= users.count){
            print(view.iUser);
            addView("result", setIndex);
        }else{
            print(view.iUser);
            addView("turn", setIndex);
        }
        
        
        
    }
    
    
    //
    func SwitchRound(view: TeamResultView) {
        //
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
}

