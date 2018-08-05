//
//  UserDataHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 21/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserDataHelper{
    
    private static var entityName = "Users";
    // create
    class func createUser(_ name: String, teamId: Int, completion: @escaping (_ success: NSManagedObject?) -> Void){
        
        // check if name exist
            // if exist
                // check if duplicate allowed
                    // if allowed
                        // check if name exist in team
                            // if exist return
                            // if not just create
                    // if not allowed return
            // if not exist just create
        
        if(self.checkIfUserExist(name: name)){
            
            if(SettingsDataHelper.isDuplicateAllowed()){
                
                if(self.isUserUniqueInTeam(name, teamId: teamId)){
                    completion(nil);
                }else{
                    self.create(name, teamId: teamId) { (obj) in
                        completion(obj)
                    }
                }
                
            }else{
                completion(nil)
            }
            
            
        }else{
            self.create(name, teamId: teamId) { (obj) in
                completion(obj)
            }
        }
        
        
        
    }
    
    class private func create(_ name: String, teamId: Int, completion: @escaping (_ success: NSManagedObject?) -> Void){
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let item = NSManagedObject(entity: entity!, insertInto: context) as! Users;
        item.setValue(name, forKey: "name");
        item.setValue(teamId, forKey: "teamId");
        item.setValue(0, forKey: "counter");
        
        do{
            try context.save();
            completion(self.returnUserByName(name));
        } catch {
            
            print("Failed")
            completion(nil);
        }
    }
    
    // update
    class func updateUser(iuser: Users, count: Int){
        // not required but may be in future
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        iuser.counter = Int32(count)
        
        do{
            try context.save();
            context.processPendingChanges();
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    // return
    class func returnUserByName(_ name: String) ->NSManagedObject?{
        
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
    
    // special delete
    class func deleteUser(_ obj: NSManagedObject, teamId: Int, completion: @escaping (_ success: Bool) -> Void){
        
        let item = (obj as? Users)!
        if(!self.checkIfUserExist(name: item.name!)){
            completion(false);
        }else{
            
            let name = item.name!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
            let appDelegate =  AppDelegate.getAppDelegate();
            let context = appDelegate.persistentContainer.viewContext;
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
            let predicate1 = NSPredicate(format: "name = %@", name)
            let predicate2 = NSPredicate(format: "teamId = %d", teamId)
            let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2]);
            request.predicate = predicateCompound;
            request.returnsObjectsAsFaults = false;
            request.fetchLimit = 1
            
            do{
                
                let result = try context.fetch(request).first;
//                if(result != nil){
                    context.delete(obj);
                    context.processPendingChanges();
                    try context.save();
                    completion(true);
//                }else{
//                    completion(false);
//                }
                
                
                
                
                
            } catch {
                
                print("Failed")
                completion(false);
            }
        }
        
        
    }
    
    // delete
    class func deleteUser(_ obj: NSManagedObject, completion: @escaping (_ success: Bool) -> Void){
        
        let item = (obj as? Users)!
        if(!self.checkIfUserExist(name: item.name!)){
            completion(false);
        }else{
            
            let name = item.name!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
            let appDelegate =  AppDelegate.getAppDelegate();
            let context = appDelegate.persistentContainer.viewContext;
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
            request.predicate = NSPredicate(format: "name = %@", name);
            request.returnsObjectsAsFaults = false;
            request.fetchLimit = 1
            
            do{
                
                let result = try context.fetch(request).first;
                context.delete(obj);
                
                try context.save();
                completion(true);
                
            } catch {
                
                print("Failed")
                completion(false);
            }
        }
        
    }
    
    class func loopAllUsersForACelebrityExist(_ name: String) -> Bool{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
//        let predicate1 = NSPredicate(format: "name = %@", name)
        let predicate2 = NSPredicate(format: "ANY itsCelebs.name = %@", name)
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2]);
        request.predicate = predicateCompound
        request.returnsObjectsAsFaults = false;
        
//        request.fetchLimit = 1
        
        do {
            
            let c = try context.count(for: request);
            print(c);
            if( c > 0 ){
                return true;
            }else{
                return false;
            }
            
        } catch {
            
            print("Failed")
            return false;
        }
        
    }
    
    class func getAllUsers() -> [NSManagedObject]{
        
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
                c.append(data);
            }
            
        } catch {
            
            print("Failed")
        }
        
        return c;
    }
    
    class func setAllUsersCounterToZero(){
        var c = [NSManagedObject]();
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            
            for user in result as! [Users] {
                user.counter = Int32(0);
            }
            try context.save();
            context.processPendingChanges();
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    class func getUsersTeamwise(completion: @escaping (_ teams: [[Users]]) -> Void) {
        //
        var team1: [Users] = [Users]();
        var team2: [Users] = [Users]();
        var team3: [Users] = [Users]();
        var team4: [Users] = [Users]();
        
        if let uss = getAllUsers() as? [Users]{
            for each in uss{
                
                switch (Int(each.teamId)){
                    case 1:
                        team1.append(each);
                        break;
                    case 2:
                        team2.append(each);
                        break;
                    case 3:
                        team3.append(each);
                        break;
                    case 4:
                        team4.append(each);
                        break;
                    default:
                        break;
                }
                
                
            }
        };
        
        completion([team1, team2, team3, team4]);
    
    
    
    
    }
    
    
    class func isUserUniqueInTeam(_ name: String, teamId: Int) -> Bool{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        let predicate1 = NSPredicate(format: "name = %@", name)
        let predicate2 = NSPredicate(format: "teamId = %d", teamId)
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2]);
        request.predicate = predicateCompound
        request.returnsObjectsAsFaults = false;
        
        request.fetchLimit = 1
        
        do {
            
            let c = try context.count(for: request);
            print(c);
            if( c > 0 ){
                return true;
            }else{
                return false;
            }
            
        } catch {
            
            print("Failed")
            return false;
        }
        
    }
    
    
    
    class func checkIfUserExist(name: String) -> Bool{
        
        let name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.predicate = NSPredicate(format: "name = %@", name);
        request.returnsObjectsAsFaults = false;
        request.fetchLimit = 1
        
        do {
            
            let c = try context.count(for: request);
            if( c <= 0){
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
