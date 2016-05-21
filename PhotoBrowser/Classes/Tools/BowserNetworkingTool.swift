//
//  BowserNetworkingTool.swift
//  PhotoBrowser
//
//  Created by 911 on 16/5/15.
//  Copyright © 2016年 bin. All rights reserved.
//

import UIKit
import Alamofire


class BowserNetworkingTool: NSURLSession {

    static let manager = BowserNetworkingTool()
    
    
    func loadData(offSet : Int)  {
        
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=0&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2"
        
        Alamofire.request(.POST, urlString, parameters: nil).validate(contentType: ["text/html"]).responseJSON { (response) in
            
            print(response.result.value)
            
            
        }
        
    }
    
    func loadNewData(offset : Int,finshedCallback : ([[String : NSObject]])->()) {
        
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=\(offset)&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2"
        
        let url = NSURL(string: urlString)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            do {
                let dict =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                
                guard let dataArray = dict["data"] as? [[String : NSObject]] else {
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), { 
                    
                    finshedCallback(dataArray)
                })
                
            }catch{
                
            }
        }.resume()
        
        
        
    }
    
    
    
    
}
