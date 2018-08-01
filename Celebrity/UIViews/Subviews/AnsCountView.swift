//
//  AnsCountView.swift
//  Celebrity
//
//  Created by Xtreme Hardware on 01/08/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

@objc protocol AnsCountViewDelegate {
    func SwitchView(view : AnsCountView);
}

class AnsCountView: UIView{
    
    @IBOutlet weak var imgWrongicon: UIImageView!
    @IBOutlet weak var imgWriteicon: UIImageView!
    
    @IBOutlet weak var wrongCollection: UICollectionView!
    @IBOutlet weak var writeCollection: UICollectionView!
    
    var celebArrayRite: [Celeb] = [Celeb]();
    var celebArrayWrong: [Celeb] = [Celeb]();
    var iUser : Users!;
    weak var delegate:AnsCountViewDelegate?;
    
    
    
    override func awakeFromNib() {
        //
        imgWriteicon.backgroundColor = CSS.colorWithHexString(Colors.green);
        imgWriteicon.roundImageBorder(color: Colors.white, width: 5);
        imgWrongicon.backgroundColor = CSS.colorWithHexString(Colors.red);
        imgWrongicon.roundImageBorder(color: Colors.white, width: 5);
        
        wrongCollection.delegate = self;
        writeCollection.delegate = self;
        wrongCollection.dataSource = self;
        writeCollection.dataSource = self;
        
        setCV(wrongCollection);
        setCV(writeCollection);
        
    }
    
    func setCV(_ collectionView: UICollectionView){
        collectionView.register(UINib(nibName: "CelebCVC", bundle: nil), forCellWithReuseIdentifier: "CelebCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .always
        }
    }
    
    func setData( user: Users, write : [Celeb] , wrong : [Celeb]){
        celebArrayRite = write;
        celebArrayWrong = wrong;
        self.iUser = user;
        self.wrongCollection.reloadData();
        self.writeCollection.reloadData();
    }
    
}

extension AnsCountView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        let width = collectionView.frame.width;
        let height = collectionView.frame.height/5;
        return CGSize(width: width, height: height);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CelebCVC.self), for: indexPath) as? CelebCVC
            else { fatalError("unexpected cell in collection view") }
        
        if(collectionView == self.writeCollection){
            cell.setData(celebArrayRite[indexPath.row]);
        }else{
            cell.setData(celebArrayWrong[indexPath.row]);
        }
        
        
        return cell;
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        if(collectionView == self.writeCollection){
            return celebArrayRite.count;
        }else{
            return celebArrayWrong.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
        
    }
    
    
    
    
}


