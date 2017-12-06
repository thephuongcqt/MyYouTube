//
//  Extensions+UIImageView.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/4/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
    // When using UIImageView inside tablevview or collectionview
    // if image load at wrong position you must custom UIImageView and check url on download image
    // var imageURLString: String?
    func loadImageUsingCache(with urlString: String){
        // imageURLString = urlString
        self.image = nil
        //check image is cached or not
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: urlString as NSString)
                    self.image = downloadImage
//                    if self.imageUrlString == urlString{
//                        self.image = donwloadImage
//                    }
                }
                
            }
        }).resume()
    }
/**
     Load and caching image from url
     - Parameters:
         - urlString: The string url to download image
         - completion: Callback method to handle when image load done
*/
    func loadImageUsingCache(with urlString: String, completion: @escaping () -> ()){
        self.image = nil
        //check image is cached or not
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            completion()
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: urlString as NSString)
                    self.image = downloadImage
                }
                
            }
            completion()
        }).resume()
    }
}
