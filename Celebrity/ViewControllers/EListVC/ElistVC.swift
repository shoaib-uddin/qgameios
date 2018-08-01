//
//  ElistVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 22/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EListVC: UIViewController, AddUserViewDelegate, AddCelebViewDelegate, EListTVCDelegate{
    
    var listType: String = "users";
    var username: NSManagedObject!;
    var collectionArray: [NSManagedObject] = [NSManagedObject]();
    var adduserview: AddUserView!;
    var addcelebview: AddCelebView!;
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbltype: UILabel!
    @IBOutlet weak var btnBeReady: UIButton!
    
    
    override func viewDidLoad() {
        //
        
        tableView.register(UINib(nibName: "EListTVC", bundle: nil), forCellReuseIdentifier: "EListTVC");
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 85.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
        
        self.title = ""
        load(listType);
        
        
    }
    
    private func load(_ key: String){
        
        switch key {
        case "users":
            //
            self.title = "Players";
            self.btnBeReady.isHidden = false;
            self.collectionArray = UserDataHelper.getAllUsers();
            self.tableView.reloadData();
            break;
        case "celebs":
            //
            self.btnBeReady.isHidden = true;
            let name = DataHelper.returnName(self.username);
            self.title = "\(name)'s Celebrities";
            
            
            self.collectionArray = CelebDataHelper.getAllCelebsByUser(self.username);
            self.tableView.reloadData();
            
            
            
            
            
            break;
        default:
            // do nothing
            break;
            
        }
        
    }
    
    @IBAction func letsPlay(_ sender: UIButton) {
        PageRedirect.redirectToGameboardPage(vc: self);
    }
    @IBAction func addNewUser(_ sender: UIButton) {
        
        
        let w = self.view.frame.width;
        let h = self.view.frame.height;
        
        switch listType {
        case "users":
            //
            
            if(self.adduserview == nil){
                self.adduserview =  Bundle.main.loadNibNamed("AddUserView", owner: self, options: nil)?[0] as! AddUserView;
                self.adduserview.frame = CGRect(x: 0, y: 0, width: w, height: h);
                self.adduserview.delegate = self;
                self.adduserview.tag = 80;
                self.view.addSubview(self.adduserview)
            }
            break;
        case "celebs":
            //
            
            
            if(self.addcelebview == nil){
                self.addcelebview =  Bundle.main.loadNibNamed("AddCelebView", owner: self, options: nil)?[0] as! AddCelebView;
                self.addcelebview.frame = CGRect(x: 0, y: 0, width: w, height: h);
                self.addcelebview.delegate = self;
                self.addcelebview.tag = 80;
                self.addcelebview.setData(obj: self.username)
                self.view.addSubview(self.addcelebview)
            }
            
            
            
            
            break;
        default:
            // do nothing
            break;
            
        }
        
        
        
    }
    
    // delegate
    func refreshUserList(view: AddUserView) {
        //
        self.adduserview = nil;
        load("users");
    }
    
    // delegate
    func refreshCelebList(view: AddCelebView) {
        //
        self.addcelebview = nil;
        load("celebs");
    }
    
    // delegate
    func removeUserFromList(cell: UITableViewCell, obj: NSManagedObject) {
        
        
        
        switch listType {
        case "users":
            //
            UserDataHelper.deleteUser(obj) { (success) in
                print(success);
                self.collectionArray = UserDataHelper.getAllUsers();
                self.tableView.reloadData();
            }
            break;
        case "celebs":
            //
            CelebDataHelper.deleteCeleb(self.username as! Users, obj as! Celeb) { (success) in
                //
                self.collectionArray = CelebDataHelper.getAllCelebsByUser(self.username);
                self.tableView.reloadData()
            }
            break;
        default:
            // do nothing
            break;
            
        }
        
    }
    
        
    
    
    
}

extension EListVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collectionArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EListTVC", for: indexPath as IndexPath) as! EListTVC;
        cell.setData(self.collectionArray[indexPath.row]);
        cell.delegate = self;
        cell.selectionStyle = .none;
        
        switch self.listType {
        case "users":
            //
            
            cell.viewBar.isHidden = false;
//            cell.viewDelete.isHidden = true;
            break;
        case "celebs":
            //
            cell.viewBar.isHidden = true;
//            cell.viewDelete.isHidden = false;
            break;
        default:
            // do nothing
            break;
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch self.listType {
        case "users":
            //
            PageRedirect.redirectToElistPage(vc: self, key: "celebs", obj: self.collectionArray[indexPath.row]);
            break;
        case "celebs":
            //
            
            break;
        default:
            // do nothing
            break;
            
        }
        //PageRedirect.navToChildSubmenu(item: self.collectionArray[indexPath.row], viewController: self);
    }
    
    
    
    
}



