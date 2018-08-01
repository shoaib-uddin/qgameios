//
//  SettingsVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import SwiftIconFont

class SettingsVC: UIViewController{
    
    var teamCount: Int = 2;
    var roundCount: Int = 2;
    var timeInSec: Int = 60;
    var allowDuplic: Bool = false;
    
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRound: UILabel!
    @IBOutlet weak var sagments: UISegmentedControl!
    
    //
    override func viewDidLoad() {
        //
        if let data = SettingsDataHelper.returnSettings() as? Settings{
            self.teamCount = Int(data.teamCount);
            self.timeInSec = Int(data.timeInSec);
            self.roundCount = Int(data.roundCount);
            self.allowDuplic = Bool(data.allowDuplicate);
            
            self.lblTeam.text = "Number Of Teams - \(self.teamCount)";
            self.lblTime.text = "Turn Time - \(UtilityHelper.secIntoFormat(self.timeInSec)) minute";
            self.lblRound.text = "Number Of Round - \(self.roundCount)";
            sagments.selectedSegmentIndex = (self.allowDuplic) ? 0 : 1;
            
        }
        
        
        
    }
    
    @IBAction func changeTeamCount(_ sender: UIStepper) {
        //
        let c = Int(sender.value);
        self.teamCount = c;
        self.lblTeam.text = "Number Of Teams - \(c)";
        
        setSettings()
        
    }
    
    @IBAction func changeTimeCount(_ sender: UIStepper) {
        //
        let c = Int(sender.value);
        self.timeInSec = c;
        self.lblTime.text = "Turn Time - \(UtilityHelper.secIntoFormat(self.timeInSec)) minute";
        
        setSettings()
        
    }
    
    @IBAction func changeRoundCount(_ sender: UIStepper) {
        //
        let c = Int(sender.value);
        self.roundCount = c;
        self.lblRound.text = "Number Of Rounds - \(c)";
        
        setSettings()
        
    }
    
    @IBAction func allowDuplicate(_ sender: UISwitch) {
        //
        
        
    }
    
    @IBAction func allowDuplicates(_ sender: UISegmentedControl) {
        
        
        
        let c = (sender.selectedSegmentIndex == 0) ? true : false;
        self.allowDuplic = c;
        
        setSettings();
        
    }
    
    
    private func setSettings(){
        SettingsDataHelper.updateSettings(self.teamCount, self.roundCount, self.timeInSec, self.allowDuplic) { (obj) in
            print(obj);
        }
    }
    
    
    
        
    
    
    
}
