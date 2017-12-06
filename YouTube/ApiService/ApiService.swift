
//
//  ApiService.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/6/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let shared = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                do{
                    var videos = [Video]()
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    for dictionary in json as! [[String: Any]]{
                        let video = Video(withDictionary: dictionary)
                        videos.append(video)
                    }
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                } catch let err{
                    print(err)
                }
                }.resume()
        }
    }
}
