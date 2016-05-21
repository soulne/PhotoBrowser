//
//  HomeItem.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/16.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit

class HomeItem: NSObject {

    var q_pic_url = ""
    var m_pic_url = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    
}
