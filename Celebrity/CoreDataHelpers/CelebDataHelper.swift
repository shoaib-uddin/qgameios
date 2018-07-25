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
    class func createCeleb(_ name: String, userId: String, completion: @escaping (_ success: NSManagedObject?) -> Void){
        
        if(self.checkIfCelebExist(name: name)){
            
            completion(nil);
            
        }else if(!checkIfCelebCountExceed(userId: userId)){
            completion(nil);
        }else{
            
            let appDelegate =  AppDelegate.getAppDelegate();
            let context = appDelegate.persistentContainer.viewContext;
            
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
            let item = NSManagedObject(entity: entity!, insertInto: context) as! Celeb;
            item.setValue(name, forKey: "name");
            item.setValue(userId, forKey: "userId");
            
            do{
                try context.save();
                completion(self.returnCelebByName(name));
            } catch {
                
                print("Failed")
                completion(nil);
            }
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
    class func deleteCeleb(_ name: String, completion: @escaping (_ success: Bool) -> Void){
        
        if(!self.checkIfCelebExist(name: name)){
            
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
    
    class func getAllCelebsByUsername(name: String) -> [NSManagedObject]{
        
        var c = [NSManagedObject]();
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "userId = %@", name)
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
    
    class func checkIfCelebCountExceed(userId: String) -> Bool{
        
        let name = userId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        request.predicate = NSPredicate(format: "userId = %@", name);
        request.returnsObjectsAsFaults = false;
        request.fetchLimit = 1
        
        do {
            
            let c = try context.count(for: request);
            if( c > 10){
                return false;
            }else{
                return true;
            }
            
        } catch {
            
            print("Failed")
            return false;
        }
        
        
    }
    
    class func checkIfCelebExist(name: String) -> Bool{
        
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
