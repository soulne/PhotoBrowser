//
//  BrowserViewController.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/16.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    weak var collectionView : UICollectionView?
    
    var itemArray : [HomeItem]?
    
    var indexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

//MARK:- 设置UI
private let cellID : String = "browserCell"

extension BrowserViewController {
    
    func setupUI() {
        self.view.frame.size.width += 10
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: BrowserFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionView?.pagingEnabled = true
        if let indexPath = self.indexPath {
            self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
        }
        
        self.collectionView?.registerClass(BrowserCell.self, forCellWithReuseIdentifier: cellID)
    }
}

//MARK:- 数据代理,delegate
extension BrowserViewController {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! BrowserCell
        
        cell.item = itemArray![indexPath.row]
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(BrowserViewController.longPress(_:)))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    
    func longPress(press : UILongPressGestureRecognizer){
        if press.state == .Began {
            
            let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let saveAction = UIAlertAction(title: "保存到相册", style: .Default) { (action) in
                let indexPath = self.collectionView?.indexPathsForVisibleItems().first
                let cell = self.collectionView?.cellForItemAtIndexPath(indexPath!) as! BrowserCell
                UIImageWriteToSavedPhotosAlbum(cell.imageView!.image!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                
            }
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) in
                
            }
            
            alertVC.addAction(saveAction)
            alertVC.addAction(cancelAction)
            
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject){
        
        
    }
    
    
 
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension BrowserViewController : DismissProtocol {
    func getImageView() -> UIImageView {
        let cell = collectionView?.visibleCells().first as! BrowserCell
        
        let imageView = UIImageView(frame:cell.imageView!.frame)
        
        imageView.image = cell.imageView?.image
        
        imageView.contentMode = .ScaleAspectFill
        
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func getIndexPath() -> NSIndexPath {
//        let cell = collectionView!.visibleCells().first as! BrowserCell
//        let indexPath = collectionView!.indexPathForCell(cell)

        let indexPath = collectionView?.indexPathsForVisibleItems().last
        
        return indexPath!
    }
}
