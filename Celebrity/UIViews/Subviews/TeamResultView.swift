//
//  TeamResultView.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 02/08/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TeamResultViewDelegate {
    func SwitchRound(view : TeamResultView);
}

class TeamResultView: UIView {
    //
    
    @IBOutlet weak var lblRcount: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate:TeamResultViewDelegate?;
    var UserArray: [Users]!;
    var teamCount = 4;
    var teams: [[Users]] = [[Users]]();
    
    override func awakeFromNib() {
        //
        collectionView.register(UINib(nibName: "ResultCVC", bundle: nil), forCellWithReuseIdentifier: "ResultCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        
        
        
    }
    
    func setData(_ rcount: Int){
        
        var st = SettingsDataHelper.returnSettings() as! Settings;
        self.teamCount = Int(st.teamCount)
        self.lblRcount.text = "Round \(rcount) Finished";
        UserDataHelper.getUsersTeamwise { (teams) in
            self.teams = teams;
            self.collectionView.reloadData();
        };
        
//        self.UserArray = users;
        
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        delegate?.SwitchRound(view: self);
    }
    
}
