//
//  PageRedirectHelper.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData;

class PageRedirect {
    
    class func redirectToSettingsPage(vc: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        vc.navigationController?.pushViewController(destination, animated: true);
        
    }
    
    class func redirectToElistPage(vc: UIViewController, key: String, obj: NSManagedObject? ){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "EListVC") as! EListVC;
        destination.username = obj;
        destination.listType = key;
        vc.navigationController?.pushViewController(destination, animated: true);
        
    }
    
    class func redirectToGameboardPage(vc: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "GameBoardVC") as! GameBoardVC;
        vc.navigationController?.pushViewController(destination, animated: true);
        
    }
    
    
}
