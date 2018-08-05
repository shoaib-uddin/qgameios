//
//  UserTVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 02/08/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class UserTVC: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ ce : Users){
        lblName.text = ce.name! + " - ( \(ce.counter) )";
    }
    
}
