//
//  ResultCVC.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 02/08/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class ResultCVC: UICollectionViewCell {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var collectionArray: [Users] = [Users]();
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tableView.register(UINib(nibName: "UserTVC", bundle: nil), forCellReuseIdentifier: "UserTVC");
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 35.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
        
        
        
        self.setBorder(color: "#ffffff", radius: 0, width: 1)
        
        
    }
    
    func setData(_ users: [Users], index: Int){
        self.collectionArray = users;
        self.lblHeading.text = "Team \(index + 1)";
        self.tableView.reloadData();
        findTotal()
    }
    
    func findTotal(){
        
        var count = 0;
        for each in self.collectionArray{
            count = count + Int(each.counter)
        }
        self.lblTotal.text = "\(count)";
    }

}

extension ResultCVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collectionArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTVC", for: indexPath as IndexPath) as! UserTVC;
        cell.setData(self.collectionArray[indexPath.row]);
        cell.selectionStyle = .none;
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    
    
}




