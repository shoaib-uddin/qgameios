//
//  TeamDataHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 21/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TeamDataHelper{
    
    private static var entityName = "Team";
    // create
    class func createTeam(_ name: String, completion: @escaping (_ success: NSManagedObjectID?) -> Void){
        
        if(self.checkIfTeamExist(name: name)){
            
            completion(nil);
            
        }else{
            
            let appDelegate =  AppDelegate.getAppDelegate();
            let context = appDelegate.persistentContainer.viewContext;
            
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
            let item = NSManagedObject(entity: entity!, insertInto: context) as! Team;
            item.setValue(name, forKey: "name");
            
            do{
                
                try context.save();
                completion(item.objectID);
                
            } catch {
                
                print("Failed")
                completion(nil);
            }
        }
        
        
    }
    
    // update
    class func updateTeamByANumber(count: Int){
        // not required but may be in future
        
        // check the number
        // number is less then minTeamCount or greater then maxTeamCount then return
        // from 0 to max team count
            // if team exist for count - leave it
            // if team exist after count - delete it and delete all associated users and celebs with it
        
        if(count > DataHelper.maxTeamCount || count < DataHelper.minTeamCount){
            return;
        }
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        
        for index in 1...(DataHelper.maxTeamCount){
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
            let name = "Team \(index)".trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
            request.predicate = NSPredicate(format: "name = %@", name);
            request.returnsObjectsAsFaults = false;
            request.fetchLimit = 1
            
            do {
                
                let findCount = try context.count(for: request);
                if(findCount == 0){
                    // create a team
                    if(count <= index){
                        self.createTeam(name) { (obj) in
                            print("created", obj);
                        }
                    }
                    
                }else{
                    
                    if(count > index){
                        self.deleteTeam(name) { (obj) in
                            print(obj);
                        }
                    }
                    
                    
                }
                
                
            } catch {
                
                print("Failed")
                
            }
        }
        
        
        
    }
    
    // return
    class func returnTeamByName(_ name: String) ->NSManagedObject?{
        
        let name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.predicate = NSPredicate(format: "name = %@", name);
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
    
    // delete
    class func deleteTeam(_ name: String, completion: @escaping (_ success: Bool) -> Void){
        
        if(self.checkIfTeamExist(name: name)){
            
            completion(false);
            
        }else{
            
            let name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
            let appDelegate =  AppDelegate.getAppDelegate();
            let context = appDelegate.persistentContainer.viewContext;
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
            request.predicate = NSPredicate(format: "name = %@", name);
            request.returnsObjectsAsFaults = false;
            request.fetchLimit = 1
            
            do{
                
                let result = try context.fetch(request).first;
                context.delete(result as! NSManagedObject);
                
                try context.save();
                completion(true);
                
            } catch {
                
                print("Failed")
                completion(false);
            }
        }
        
    }
    
    class func getAllTeams() -> [NSManagedObject]{
        
//        var c = [[String:Any]]();
        var c = [NSManagedObject]();
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            
            for data in result as! [NSManagedObject] {
                
//                var i = [
//                    "name": data.value(forKey: "name") as! String,
//                    "highscore": data.value(forKey: "highscore") as! Decimal,
//                    "teamId": data.value(forKey: "teamId") as! Decimal
//                    ] as [String : Any]
//                print(i)
                c.append(data);
            }
            
        } catch {
            
            print("Failed")
        }
        
        return c;
    }
    
    class func checkIfTeamExist(name: String) -> Bool{
        
        let name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.predicate = NSPredicate(format: "name = %@", name);
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
