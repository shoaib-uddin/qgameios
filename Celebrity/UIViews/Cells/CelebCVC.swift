//
//  CelebCVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 01/08/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class CelebCVC: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ ce : Celeb){
        lblName.text = ce.name;
    }

}
