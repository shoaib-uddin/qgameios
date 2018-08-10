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
    
    @IBOutlet weak var parentVIew: UIView!;
    var settings: Settings!;
    var roundCount = 2;
    var t_celebrities: [Celeb] = [Celeb]();
    var s_celebrities: [Celeb] = [Celeb]();
    var users: [Users] = [Users]();
    var userTurnView: UserTurnView!;
    var ansCountView: AnsCountView!;
    var teamResultView: TeamResultView!;
    var setIndex: Int = 0;
    var roundIndex: Int = 1;
    
    
    override func viewDidLoad() {
        //
        fetchall();
        addView("turn", setIndex, roundIndex);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func fetchall(){
        UserDataHelper.setAllUsersCounterToZero();
        users = UserDataHelper.getAllUsers() as! [Users];
        settings = SettingsDataHelper.returnSettings() as! Settings;
        t_celebrities = CelebDataHelper.getAllCelebs();
        roundCount = Int(settings.roundCount);
    }
    
    
    
    func addView(_ v: String, _ index: Int, _ roundC: Int){
        
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
            
            if(index == 0){
                self.userTurnView.setData(users[index], self.t_celebrities);
            }else{
                self.userTurnView.setData(users[index], self.s_celebrities);
            }
            
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
            self.teamResultView.setData(roundIndex);
            
            
            
        default:
            break
        }
        
    }
    
    
    
    // delegates
    func SwitchPlayer(view: UserTurnView, user: Users, write: [Celeb], wrong: [Celeb], remain: [Celeb]) {
        //
        print(remain.count);
        s_celebrities.removeAll();
        s_celebrities.append(contentsOf: remain);
        
        if(self.userTurnView != nil){
            self.userTurnView.removeFromSuperview();
            self.userTurnView = nil;
        }
        
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
        
        if(setIndex >= users.count || s_celebrities.count == 0){
            addView("result", setIndex, roundIndex);
        }else{
            addView("turn", setIndex, roundIndex);
        }
        
        
        
    }
    
    
    //
    func SwitchRound(view: TeamResultView) {
        //
        
        view.removeFromSuperview();
        self.teamResultView = nil;
        
        roundIndex = roundIndex + 1;
        if(roundIndex > roundCount){
            self.navigationController?.popViewController(animated: true);
        }else{
            
            if(self.s_celebrities.count <= 0){
               self.s_celebrities.append(contentsOf: self.t_celebrities)
            };
            
            if(setIndex >= users.count){
                setIndex = 0
            }
            addView("turn", setIndex, roundIndex);
        }
        
    }
    
    
    
    
}

