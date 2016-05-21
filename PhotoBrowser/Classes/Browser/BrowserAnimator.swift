//
//  BrowserAnimator.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/16.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit

class BrowserAnimator: NSObject {
    var isPresented = false
    
    var indexPath : NSIndexPath?
    
    weak var dismissDelegate : DismissProtocol?
    weak var presentedDelegate : PresentedProtocol?
}


//MARK-: modal 代理
extension BrowserAnimator : UIViewControllerTransitioningDelegate{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

extension BrowserAnimator : UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
     
        if isPresented {
            
            guard let presentedDelegate = presentedDelegate,let indexPath = indexPath else{
                return
            }
            
            let imageView = presentedDelegate.getImageView(indexPath)
            imageView.frame = presentedDelegate.getStartRect(indexPath)
            transitionContext.containerView()?.addSubview(imageView)
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            transitionContext.containerView()?.addSubview(presentView)
            presentView.alpha = 0
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                imageView.frame = calculateImageViewFrame(imageView.image!)
                },completion: {(_) in
                    presentView.alpha = 1
                    transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                    imageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                })
            
        }else{
            
            guard let dismissDelegate = dismissDelegate,presentedDelegate = presentedDelegate else {
                return
            }
            let indexPath = dismissDelegate.getIndexPath()
            
            presentedDelegate.scrollToIndex(indexPath)
            
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            let imageView = dismissDelegate.getImageView()
            
            transitionContext.containerView()?.addSubview(imageView)
            
            dismissView?.alpha = 0.0
            
            UIView.animateWithDuration(1, animations: {
                
                    imageView.frame = presentedDelegate.getStartRect(indexPath)
                
                }, completion: { (finshed) in
                
                    imageView.removeFromSuperview()
                    dismissView?.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
            
            
            
        }
        
    }
    
}


func calculateImageViewFrame(image:UIImage) -> CGRect {
    let imageW :CGFloat = UIScreen.mainScreen().bounds.width
    let imageH :CGFloat = image.size.height * imageW / image.size.width
    let imageX :CGFloat = 0;
    let imageY :CGFloat = (UIScreen.mainScreen().bounds.height - imageH) * 0.5
    return CGRect(x: imageX, y: imageY, width: imageW, height: imageH)
}

protocol DismissProtocol : class{
    func getIndexPath() -> NSIndexPath
    func getImageView() -> UIImageView
}

protocol PresentedProtocol :class{
    func getStartRect(indexPath : NSIndexPath) -> CGRect
    func getImageView(indexPath : NSIndexPath) -> UIImageView
    func scrollToIndex(indexPath : NSIndexPath)
}
