//
//  Extensions.swift
//  chatApp
//
//  Created by NandN on 8/23/16.
//  Copyright © 2016 5 O'Clock. All rights reserved.
//

import UIKit

let imageCache = NSCache()

extension UIImageView{
    func loadImageUsingCacheWithUrlString(urlString: String){
        
        self.image = nil
        //check cache for image first
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            return
        }
    let url = NSURL(string: urlString)
    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
    
    // download hit an error so let's return out
    if error != nil {
    print(error)
    return
    }
    dispatch_async(dispatch_get_main_queue(), {
        
        if let downloadedImage = UIImage(data: data!){
        
            imageCache.setObject(downloadedImage, forKey: urlString)
        
            self.image = downloadedImage
        }
    })
    
    
    }).resume()
    

    }

}