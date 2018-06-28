//
//  Extensions.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/27/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImagesUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        
                        self.image = downloadedImage
                    }
                }
            }.resume()
        }
    }
}
