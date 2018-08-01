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
import DropDown


@objc protocol AddUserViewDelegate {
    func refreshUserList(view : AddUserView);
}

class AddUserView: UIView{
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var forTeam: UILabel!
//    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var showDropdown: UIButton!
    @IBOutlet weak var btnRemoveUser: UIButton!
    
    weak var delegate:AddUserViewDelegate?;
    var maxteamCount: Int = 4;
    var teamValue: Int = 1;
    let dropDown = DropDown();
    
    
    
    override func awakeFromNib() {
        //
        if let set = SettingsDataHelper.returnSettings() as? Settings{
            self.maxteamCount = Int(set.teamCount);
//            self.stepper.maximumValue = Double(self.maxteamCount);
        };
        
        self.layoutSubviews();
        self.colorView.backgroundColor = CSS.colorWithHexString(Colors.team[0]);
        setDropDown();
        
    }
    
    @IBAction func removeUser(_ sender: UIButton) {
        
        // check if user and team exist ... remove user
        // after that delegate fires to refresh list
//        UserDataHelper.deleteUser(self.txtName.text!, teamId: teamValue) { (success) in
//            print(success);
//            self.delegate?.refreshUserList(view: self);
//            self.removeFromSuperview();
//        }
        
        
    }
    
    
    @IBAction func showDD(_ sender: UIButton) {
        dropDown.show();
    }
    
    
    private func setDropDown(){
        dropDown.anchorView = self.showDropdown // UIView or UIBarButtonItem
        dropDown.width = self.showDropdown.frame.width;
        dropDown.dataSource = [];
        
        for index in 1...self.maxteamCount {
            dropDown.dataSource.append("Team \(index)");
        }
        
        dropDown.direction = .bottom;
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "ChoseTeamTVC", bundle: nil)
        
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? ChoseTeamTVC else { return }
            
            // Setup your custom UI components
            cell.optionLabel.text = self.dropDown.dataSource[index];
            cell.colorView.backgroundColor = CSS.colorWithHexString(Colors.team[index]);
        }
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.forTeam.text = item;
            self.colorView.backgroundColor = CSS.colorWithHexString(Colors.team[index]);
            self.teamValue = index + 1;
            
        }
        
    }
    
    
    
    @IBAction func cancelView(_ sender: UIButton) {
        self.delegate?.refreshUserList(view: self);
        self.removeFromSuperview();
    }
    
    @IBAction func addView(_ sender: UIButton) {
        
        let t = self.txtName.text!;
        
        UserDataHelper.createUser(t, teamId: teamValue) { (obj) in
            print(obj);
            self.delegate?.refreshUserList(view: self);
            self.removeFromSuperview();
        }
    }
    
    @IBAction func setTeam(_ sender: UIStepper) {
        self.forTeam.text = "For - Team \(Int(sender.value))";
    }
    
    
    
}
