//
//  HomeCell.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/15.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var item : HomeItem? {
        didSet{
            guard let item = self.item else {
                return
            }
            let imgURL = NSURL(string:item.q_pic_url)
            self.imageView.sd_setImageWithURL(imgURL, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.redColor()
    }
    
}
