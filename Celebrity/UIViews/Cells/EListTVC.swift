//
//  EListTVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit
import CoreData
import LKAlertController

@objc protocol EListTVCDelegate {
    func removeUserFromList(cell : UITableViewCell, obj: NSManagedObject);
    
}

class EListTVC: UITableViewCell {

    var name = "";
    var type = ""
    weak var delegate:EListTVCDelegate?;
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgEdit: UIImageView!
    @IBOutlet weak var imgDelete: UIImageView!
    
    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var viewBar: UIView!
    
    var obj: NSManagedObject!;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CSS.setFontImageVisualsMaterial(imgEdit, name: "menu", color: "#000000")
        CSS.setFontImageVisualsMaterial(imgDelete, name: "delete", color: "#000000");
        self.colorView.backgroundColor = CSS.colorWithHexString("#FFFFFF");
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: NSManagedObject){
        
        self.obj = data;
        
        if let data = data as? Users{
            self.type = "Player";
            var a = ( data.value(forKey: "teamId") as! Int ) - 1;
            a = (a <= 0) ? 0 : a;
            let b = data.value(forKey: "name") as! String
            self.lblname.text = " " + b
            self.name = self.lblname.text!;
            
            self.colorView.backgroundColor = CSS.colorWithHexString(Colors.team[a]);
            
        }
        
        if let data = data as? Celeb{
            self.type = "Celebrity";
            self.lblname.text = data.value(forKey: "name") as! String;
            self.name = self.lblname.text!;
        }
        
        
        
        
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        UtilityHelper.AlertConfirm("Are you sure you want to remove this \(self.type)?") {
            self.delegate?.removeUserFromList(cell: self, obj: self.obj);
        }
        
    }
    
    
}


