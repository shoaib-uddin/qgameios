//
//  EListTVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit
import CoreData

@objc protocol EListTVCDelegate {
    func removeUserFromList(cell : UITableViewCell, name: String);
    
}

class EListTVC: UITableViewCell {

    var name = "";
    weak var delegate:EListTVCDelegate?;
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgEdit: UIImageView!
    @IBOutlet weak var imgDelete: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CSS.setFontImageVisualsMaterial(imgEdit, name: "menu", color: "#000000")
        CSS.setFontImageVisualsMaterial(imgDelete, name: "delete", color: "#000000")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: NSManagedObject){
        
        if let data = data as? Users{
            self.lblname.text = data.value(forKey: "name") as! String ?? "";
            self.name = self.lblname.text!;
        }
        
        if let data = data as? Celeb{
            self.lblname.text = data.value(forKey: "name") as! String ?? "";
            self.name = self.lblname.text!;
        }
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        delegate?.removeUserFromList(cell: self, name: self.name);
    }
    
    
}


