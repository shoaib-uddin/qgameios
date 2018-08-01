//
//  UserTurnView.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 30/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc protocol UserTurnViewDelegate {
    func SwitchPlayer(view : UserTurnView);
}

class UserTurnView: UIView{
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblCelebname: UILabel!
    @IBOutlet weak var lblWritecount: UILabel!
    @IBOutlet weak var lblWrongcount: UILabel!
    @IBOutlet weak var imgWriteicon: UIImageView!
    @IBOutlet weak var imgWrongicon: UIImageView!
    @IBOutlet weak var imgPlusicon: UIImageView!
    
    weak var delegate:UserTurnViewDelegate?;
    var settings = SettingsDataHelper.returnSettings() as! Settings;
    var p : Int = 0;
    var celebArray: [Celeb] = [Celeb]();
    var celebArrayRite: [Celeb] = [Celeb]();
    var celebArrayWrong: [Celeb] = [Celeb]();
    var visibleCeleb: Celeb!;
    
    
    override func awakeFromNib() {
        //
        
        lblWritecount.backgroundColor = CSS.colorWithHexString(Colors.green);
        lblWritecount.roundImageBorder(color: Colors.green, width: 1);
        lblWrongcount.backgroundColor = CSS.colorWithHexString(Colors.red);
        lblWrongcount.roundImageBorder(color: Colors.red, width: 1);
        imgWriteicon.backgroundColor = CSS.colorWithHexString(Colors.green);
        imgWriteicon.roundImageBorder(color: Colors.white, width: 5);
        imgWrongicon.backgroundColor = CSS.colorWithHexString(Colors.red);
        imgWrongicon.roundImageBorder(color: Colors.white, width: 5);
        imgPlusicon.backgroundColor = CSS.colorWithHexString(Colors.orange);
        imgPlusicon.roundImageBorder(color: Colors.white, width: 5);
        CSS.setFontImageVisualsMaterial(imgWrongicon, name: "close", color: Colors.white);
        CSS.setFontImageVisualsMaterial(imgWriteicon, name: "done", color: Colors.white);
        CSS.setFontImageVisualsMaterial(imgPlusicon, name: "add", color: Colors.white);
        
        
        p = Int(settings.timeInSec);
        
    }
    
    func setData(_ user: Users){
        
        lblUsername.text = "\(user.name)'s turn"
        celebArray = CelebDataHelper.getAllCelebsByUser(user) as! [Celeb];
        let rand = UtilityHelper.randomNumber(inRange: 0...(celebArray.count - 1))
        showACeleb(celebArray[rand], rand);
    }
    
    func startTImeOut(){
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.loopCountdownCallback(_ :)), userInfo: nil, repeats: true);
        
    }
    
    @objc func loopCountdownCallback(_ timer: Timer){
        
        
        self.lblTime.text = "\(UtilityHelper.secIntoFormat(p))";
        
        if(p < 0){ timer.invalidate() }
        else{
            p = p - 1;
            self.lblTime.text = "\(UtilityHelper.secIntoFormat(p))";
        }
    }
    
    func showACeleb(_ ce: Celeb, _ index: Int){
        
        lblCelebname.text = ce.name;
        startTImeOut()
        
    }
    
    

    
    
}
