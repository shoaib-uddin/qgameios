//
//  DataHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 21/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataHelper{
    
    public static var minTeamCount = 2;
    public static var maxTeamCount = 4;
    
    
    
    // create initial records here and call it on app init
    class func createRecords(){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        // setting backgrounds paths
        
        
        
        // save all default features
        do {
            try context.save();
            
        } catch {
            print("Failed saving")
        }
        
    }

}
