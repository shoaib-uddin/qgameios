//
//  UserTurnView.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 30/07/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc protocol UserTurnViewDelegate {
    func SwitchPlayer(view : UserTurnView, user: Users, write: [Celeb], wrong: [Celeb], remain: [Celeb]);
}

class UserTurnView: UIView{
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblWritecount: UILabel!
    @IBOutlet weak var lblWrongcount: UILabel!
    @IBOutlet weak var imgWriteicon: UIImageView!
    @IBOutlet weak var imgWrongicon: UIImageView!
    @IBOutlet weak var imgPlusicon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    weak var delegate:UserTurnViewDelegate?;
    var settings = SettingsDataHelper.returnSettings() as! Settings;
    var p : Int = 0;
    var celebArray: [Celeb] = [Celeb]();
    var celebArrayRite: [Celeb] = [Celeb]();
    var celebArrayWrong: [Celeb] = [Celeb]();
    var celebArraySkip: [Celeb] = [Celeb]();
    var visibleCeleb: Celeb!;
    var tmr: Timer!;
    var iuser: Users!;
    
    override func awakeFromNib() {
        //
        lblWritecount.text = "\(0)";
        lblWrongcount.text = "\(0)";
        lblWritecount.backgroundColor = CSS.colorWithHexString(Colors.green);
        lblWritecount.roundImageBorder(color: Colors.green, width: 1);
        lblWrongcount.backgroundColor = CSS.colorWithHexString(Colors.red);
        lblWrongcount.roundImageBorder(color: Colors.red, width: 1);
        imgWriteicon.backgroundColor = CSS.colorWithHexString(Colors.green);
        imgWriteicon.roundImageBorder(color: Colors.white, width: 5);
        imgWrongicon.backgroundColor = CSS.colorWithHexString(Colors.red);
        imgWrongicon.roundImageBorder(color: Colors.white, width: 5);
        imgPlusicon.backgroundColor = CSS.colorWithHexString(Colors.orange);
        imgPlusicon.roundImageBorder(color: Colors.white, width: 5);
        CSS.setFontImageVisualsMaterial(imgWrongicon, name: "close", color: Colors.white);
        CSS.setFontImageVisualsMaterial(imgWriteicon, name: "done", color: Colors.white);
        CSS.setFontImageVisualsMaterial(imgPlusicon, name: "add", color: Colors.white);
        p = Int(settings.timeInSec);
        
        collectionView.register(UINib(nibName: "CelebCVC", bundle: nil), forCellWithReuseIdentifier: "CelebCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        
    }
    
    func setData(_ user: Users, _ c: [Celeb]){
        
        lblUsername.text = "\(user.name!)'s turn";
        celebArray.removeAll()
        celebArray.append(contentsOf: c);
        self.iuser = user;
        startTImeOut()
        
    }
    
    func startTImeOut(){
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.loopCountdownCallback(_ :)), userInfo: nil, repeats: true);
        
    }
    
    @objc func loopCountdownCallback(_ timer: Timer){
        
        
        self.lblTime.text = "\(UtilityHelper.secIntoFormat(p))";
        
        if(p <= 0){
            
            timer.invalidate();
            invalidateAllAnswers()
            
        }
        else{
            p = p - 1;
            self.lblTime.text = "\(UtilityHelper.secIntoFormat(p))";
        }
    }
    
    @IBAction func wrongAnswer(_ sender: UIButton) {
        let i = returnVisibleIndexPath();
        celebArrayWrong.append(celebArray[i.row]);
        celebArray.remove(at: i.row);
        collectionView.reloadData();
        lblWrongcount.text = "\(celebArrayWrong.count)";
        checkIfCelebsEnds()
    }
    
    @IBAction func writeAnswer(_ sender: UIButton) {
        let i = returnVisibleIndexPath();
        celebArrayRite.append(celebArray[i.row]);
        celebArray.remove(at: i.row);
        collectionView.reloadData();
        lblWritecount.text = "\(celebArrayRite.count)";
        checkIfCelebsEnds()
    }
    
    @IBAction func skipAnswer(_ sender: UIButton) {
        let i = returnVisibleIndexPath();
        celebArraySkip.append(celebArray[i.row]);
        celebArray.remove(at: i.row);
        collectionView.reloadData();
        checkIfCelebsEnds()
    }
    
    func invalidateAllAnswers(){
        
        delegate?.SwitchPlayer(view: self, user: iuser, write: celebArrayRite, wrong: celebArrayWrong, remain: celebArray + celebArraySkip + celebArrayWrong);
    }
    
    
    
    func returnVisibleIndexPath() -> IndexPath {
        var visibleRect: CGRect = CGRect()
        visibleRect.origin = (collectionView?.contentOffset)!
        visibleRect.size = (collectionView?.bounds.size)!
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath? = collectionView?.indexPathForItem(at: visiblePoint)
        return visibleIndexPath!;
    }
    
    func checkIfCelebsEnds(){
        if(celebArray.count <= 0){
            delegate?.SwitchPlayer(view: self, user: iuser, write: celebArrayRite, wrong: celebArrayWrong, remain: celebArray + celebArraySkip + celebArrayWrong);
        }
    }
    

    
    
}
