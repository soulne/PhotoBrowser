//
//  BrowserCell.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/16.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit
import SDWebImage

class BrowserCell: UICollectionViewCell {

    weak var imageView : UIImageView?
    var item : HomeItem? {
        didSet{
            guard let item = item else{
                return
            }
            
            var image = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(item.q_pic_url)
            
            if image == nil {
                image = UIImage(named: "empty_picture")
            }
            
            imageView?.frame = calculateImageViewFrame(image)
            
            guard let url = NSURL(string: item.m_pic_url) else{
                imageView?.image = image
                return
            }
            
            imageView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "empty_picture"), completed: { (image, _, _, _) in
                self.imageView?.frame = calculateImageViewFrame(image)
            })
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    func setupUI() {
        let imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        self.contentView.addSubview(imageView)
        self.imageView = imageView
        self.imageView?.contentMode = .ScaleAspectFill
        self.imageView?.userInteractionEnabled = true
        
        
    }
    
   
    
}
