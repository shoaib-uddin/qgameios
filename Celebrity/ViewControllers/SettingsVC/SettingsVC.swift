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
    
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRound: UILabel!
    
    //
    override func viewDidLoad() {
        //
        if let data = SettingsDataHelper.returnSettings() as? Settings{
            self.teamCount = Int(data.teamCount);
            self.timeInSec = Int(data.timeInSec);
            self.roundCount = Int(data.roundCount);
            
            self.lblTeam.text = "Number Of Teams - \(self.teamCount)";
            self.lblTime.text = "Turn Time - \(secIntoFormat(self.timeInSec)) minute";
            self.lblRound.text = "Number Of Round - \(self.roundCount)";
            
            
            
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
        self.lblTime.text = "Turn Time - \(secIntoFormat(self.timeInSec)) minute";
        
        setSettings()
        
    }
    
    @IBAction func changeRoundCount(_ sender: UIStepper) {
        //
        let c = Int(sender.value);
        self.roundCount = c;
        self.lblRound.text = "Number Of Rounds - \(c)";
        
        setSettings()
        
    }
    
    private func setSettings(){
        SettingsDataHelper.updateSettings(self.teamCount, self.roundCount, self.timeInSec) { (obj) in
            print(obj);
        }
    }
    
    
    
    func secIntoFormat(_ sec: Int) -> String{
        
        let interval = sec
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(interval))!
        print(formattedString)
        return formattedString;
        
    }
    
    
    
    
}
