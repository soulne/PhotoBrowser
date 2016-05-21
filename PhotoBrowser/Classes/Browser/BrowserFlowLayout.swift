//
//  BrowserFlowLayout.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/16.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit

class BrowserFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = self.collectionView!.bounds.size
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        
    }
}
