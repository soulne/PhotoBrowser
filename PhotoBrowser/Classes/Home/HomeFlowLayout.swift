//
//  HomeFlowLayout.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/15.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit

class HomeFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        self.setupUI()
    
    }
    
    func setupUI(){
        let margin : CGFloat = 11
        let itemWH : CGFloat = (UIScreen.mainScreen().bounds.width - 4 * margin) / 3
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin

        
    }
    
}
