
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
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        
        let urlString = "\(baseUrl)/home.json"
        fetchFeedFor(urlString: urlString, completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()){
        
        let urlString = "\(baseUrl)/trending.json"
        fetchFeedFor(urlString: urlString, completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()){
        
        let urlString = "\(baseUrl)/subscriptions.json"
        fetchFeedFor(urlString: urlString, completion: completion)
    }
    
    func fetchFeedFor(urlString: String, completion: @escaping ([Video]) -> ()){
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
