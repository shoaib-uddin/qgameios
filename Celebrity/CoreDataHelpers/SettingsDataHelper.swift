//
//  SettingsDataHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SettingsDataHelper{
    
    private static var entityName = "Settings";
    // create
    class func createSettings(_ teamCount: Int, _ roundCount: Int, _ timeInSec: Int, _ dulplicate: Bool, completion: @escaping (_ success: NSManagedObject?) -> Void){
            
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let item = NSManagedObject(entity: entity!, insertInto: context) as! Settings;
        item.setValue(Int32(teamCount), forKey: "teamCount");
        item.setValue(Int32(roundCount), forKey: "roundCount");
        item.setValue(Int32(timeInSec), forKey: "timeInSec");
        item.setValue(Bool(dulplicate), forKey: "allowDuplicate");
        
        
        do{
            
            try context.save();
            
            completion(item);
            
        } catch {
            
            print("Failed")
            completion(nil);
        }
        
        
    }
    
    // update
    class func updateSettings(_ teamCount: Int, _ roundCount: Int, _ timeInSec: Int, _ dulplicate: Bool, completion: @escaping (_ success: NSManagedObject?) -> Void){
        // not required but may be in future
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.returnsObjectsAsFaults = false;
        
        
        do {
            let result = try context.fetch(request).first as! Settings;
            if(result != nil){
                result.teamCount = Int32(teamCount);
                result.roundCount = Int32(roundCount);
                result.timeInSec = Int32(timeInSec);
                result.allowDuplicate = Bool(dulplicate);
                
                try context.save();
                completion(result);
            }else{
                
                self.createSettings(teamCount, roundCount, timeInSec, dulplicate) { (res) in
                    completion(res);
                }
                
            }
                
            
        } catch {
            
            print("Failed")
            completion(nil);
        }
    }
    
    // return
    class func returnSettings() ->NSManagedObject?{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.returnsObjectsAsFaults = false;
        request.fetchLimit = 1
        
        do {
            
            let result = try context.fetch(request).first;
            return result as? NSManagedObject;
            
        } catch {
            
            print("Failed")
            return nil;
        }
        
    }
    
    class func isDuplicateAllowed() ->Bool{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.returnsObjectsAsFaults = false;
        request.fetchLimit = 1
        
        do {
            
            let result = try context.fetch(request).first;
            if let res = result as? Settings{
                return res.allowDuplicate;
            }else{
                return false;
            };
            
        } catch {
            
            print("Failed")
            return false;
        }
        
    }
    
    
    
    // Check
    class func checkIfSettingsExist() -> Bool{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.returnsObjectsAsFaults = false;
        request.fetchLimit = 1
        
        do {
            
            let c = try context.count(for: request);
            if( c == 0){
                return false;
            }else{
                return true;
            }
            
        } catch {
            
            print("Failed")
            return false;
        }
        
        
    }
    
    
    
}
