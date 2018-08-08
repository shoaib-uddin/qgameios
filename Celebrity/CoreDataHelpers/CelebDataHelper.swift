//
//  CelebDataHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 23/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CelebDataHelper{
    
    private static var entityName = "Celeb";
    // create
    class func createCeleb(_ name: String, userObj: NSManagedObject, completion: @escaping (_ success: NSManagedObject?) -> Void){
        
        
        let item = (userObj as? Users)!
        // if user has name return
        // else
            // if user limit exceed return
            // else
                // if duplicate allow just create
                // else
                    // loop each player with each celeb
                        // if found return
                        // else just create
        
        if(self.checkIfCelebExist(name: name, obj: userObj as! Users)){
            completion(nil)
        }else if(checkIfCelebCountExceed(userId: item)){
            completion(nil)
        }else if(SettingsDataHelper.isDuplicateAllowed()){
            self.create(name, userObj: userObj) { (success) in
                completion(success);
            }
        }else if( UserDataHelper.loopAllUsersForACelebrityExist(name) ){
            completion(nil)
        }else{
            self.create(name, userObj: userObj) { (success) in
                completion(success);
            }
        }
        
    }
    
    class private func create(_ name: String, userObj: NSManagedObject, completion: @escaping (_ success: NSManagedObject?) -> Void){
        
        let item = (userObj as? Users)!
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let itm = NSManagedObject(entity: entity!, insertInto: context) as! Celeb;
        itm.setValue(name, forKey: "name");
        itm.setValue(item.name, forKey: "userId");
        itm.setValue(false, forKey: "correct");
        item.addToItsCelebs(itm);
        
        
        do{
            try context.save();
            completion(itm);
        } catch {
            
            print("Failed")
            completion(nil);
        }
        
    }
    
    
    
    // update
    class func updateUser(){
        // not required but may be in future
    }
    
    // return
    class func returnCelebByName(_ name: String) ->NSManagedObject?{
        
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
    class func deleteCeleb(_ parent: Users, _ obj: Celeb, completion: @escaping (_ success: Bool) -> Void){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;

        parent.removeFromItsCelebs(obj);

        do{
            context.delete(obj);
            try context.save();
            context.processPendingChanges();
            completion(true);

        } catch {

            print("Failed")
            completion(false);
        }
        
    }
    
    class func getAllCelebsByUser(_ user: NSManagedObject) -> [NSManagedObject]{
        
        var c = [NSManagedObject]();
        
        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users");
        
        if let user = user as? Users{
            for e in user.itsCelebs?.allObjects as! [Celeb]{
                
                    c.append(e);
                
            }
        }
        
        return c;
        
    }
    
    class func getAllCelebs() -> [Celeb]{
        
        var cel: [Celeb] = [Celeb]();
        let users = UserDataHelper.getAllUsers() as! [Users];
        for each in users {
            
            let cells =  self.getAllCelebsByUser(each) as! [Celeb];
            cel.append(contentsOf: cells);
        }
        
        return cel;
        
        
    }
    
    class func checkIfCelebCountExceed(userId: NSManagedObject) -> Bool{
        
        let r = userId as? Users;
        let c = r?.itsCelebs?.count;
        if( c! > 10){
            return true;
        }else{
            return false;
        }
        
        
    }
    
    class func checkIfCelebExist(name: String, obj: Users) -> Bool{
        
        let name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        for item in obj.itsCelebs!{
            let n = item as? Celeb;
            if(n?.name == name){
                return true;
            }
        }
        
        return false;
        
        
        
    }
    
    
    
}
