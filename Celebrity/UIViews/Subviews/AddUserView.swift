//
//  AddUserView.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc protocol AddUserViewDelegate {
    func refreshUserList(view : AddUserView);
    
}

class AddUserView: UIView{
    
    @IBOutlet weak var forTeam: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var txtName: UITextField!
    weak var delegate:AddUserViewDelegate?;
    var maxteamCount: Int = 4;
    var teamValue: Int = 1;
    
    override func awakeFromNib() {
        //
        if let set = SettingsDataHelper.returnSettings() as? Settings{
            self.maxteamCount = Int(set.teamCount);
            self.stepper.maximumValue = Double(self.maxteamCount);
        };
        
    }
    
    @IBAction func cancelView(_ sender: UIButton) {
        self.delegate?.refreshUserList(view: self);
        self.removeFromSuperview();
    }
    
    @IBAction func addView(_ sender: UIButton) {
        
        let t = self.txtName.text!;
        UserDataHelper.createUser(t, teamId: Int(self.stepper.value)) { (obj) in
            print(obj);
            self.delegate?.refreshUserList(view: self);
            self.removeFromSuperview();
        }
    }
    
    @IBAction func setTeam(_ sender: UIStepper) {
        self.forTeam.text = "For - Team \(Int(sender.value))";
    }
    
    
    
}
