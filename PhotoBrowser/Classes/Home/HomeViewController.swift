//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/15.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit
import SDWebImage


private let cellID = "homeCell"

class HomeViewController: UICollectionViewController {
    
    lazy var itemArray : [HomeItem] = [HomeItem]()
    var animatorDelegate = BrowserAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        loadData(0)
    }
    
    
}


//MARK:- 设置UI
extension HomeViewController {
    func setupUI(){
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

//MARK:- CollectionView代理
extension HomeViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! HomeCell
        
        cell.item = itemArray[indexPath.row]
        
        if indexPath.row == itemArray.count - 1 {
            loadData(itemArray.count)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let browserVC = BrowserViewController()
        browserVC.itemArray = self.itemArray
        browserVC.indexPath = indexPath
        //设置动画代理
        browserVC.transitioningDelegate = animatorDelegate
        animatorDelegate.indexPath = indexPath
        animatorDelegate.presentedDelegate = self
        animatorDelegate.dismissDelegate = browserVC
        //modal 动画类型
//        browserVC.modalTransitionStyle = .CoverVertical
        browserVC.modalPresentationStyle = .Custom
        self.presentViewController(browserVC, animated: true, completion: nil)
    }
    
}

//MARK:- 动画代理
extension HomeViewController : PresentedProtocol {
    func getStartRect(indexPath : NSIndexPath) -> CGRect {
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? HomeCell else {
            return CGRectZero
        }
        return cell.imageView!.convertRect(cell.imageView!.bounds, toView: UIApplication.sharedApplication().keyWindow)
    }
    
    func getImageView(indexPath : NSIndexPath) -> UIImageView{
        let imageView = UIImageView()
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! HomeCell
        imageView.image = cell.imageView.image
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func scrollToIndex(indexPath : NSIndexPath) {
        
        
        guard let indexPaths = collectionView?.indexPathsForVisibleItems() else{
            return
        }
        
        if indexPaths.contains(indexPath) {
            return
        }
        
        //如果在下面
        print(indexPath.row)
        
        if indexPaths.last?.row < indexPath.row {
            
            collectionView?.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .Bottom)
            
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: false)
            
        }else {
            //如果在上面
            collectionView?.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
            
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
        }
        collectionView?.setNeedsLayout()
    }

}


//MARK:- 网络请求
extension HomeViewController{
    
    func loadData(offset:Int) {
        
        let networkTool =  BowserNetworkingTool.manager
        networkTool.loadNewData(offset) { (dataArray) in
            for dict in dataArray {
                
                self.itemArray.append(HomeItem(dict: dict))
               
            }
             self.collectionView?.reloadData()
        }
        
    }
}






