//
//  AddCelebVIew.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 23/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc protocol AddCelebViewDelegate {
    func refreshCelebList(view : AddCelebView);
    
}

class AddCelebView: UIView{
    
    var pname = "";
    var obj: NSManagedObject!;
    @IBOutlet weak var forTeam: UILabel!
    @IBOutlet weak var txtName: UITextField!
    weak var delegate:AddCelebViewDelegate?;
    
    override func awakeFromNib() {
        //
        
        
    }
    
    func setData(name: String){
        self.pname = name;
        self.forTeam.text = "For - \(name)";
    }
    
    func setData(obj: NSManagedObject){
        self.obj = obj;
        self.forTeam.text = "For - \(DataHelper.returnName(obj))";
    }
    
    @IBAction func cancelView(_ sender: UIButton) {
        self.delegate?.refreshCelebList(view: self);
        self.removeFromSuperview();
    }
    
    @IBAction func addView(_ sender: UIButton) {
        
        let t = self.txtName.text!;
        CelebDataHelper.createCeleb(self.txtName.text!, userObj: obj) { (obj) in
            print(obj);
            self.delegate?.refreshCelebList(view: self);
            self.removeFromSuperview();
        }
        
    }
    
    
    
}

