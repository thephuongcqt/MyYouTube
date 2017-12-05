//
//  Video.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/5/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit
@objcMembers
class Video: NSObject {
    // Using BaseJsonObject are the same with @objcMemeber and @objc
    @objc var thumbnail_image_name: String?
    @objc var title: String?
    @objc var channel: Channel?
    @objc var number_of_views: NSNumber?
    @objc var uploadDate: Date?
    @objc var duration: NSNumber?
    
    override init() {
        super.init()
    }
    
    init(withDictionary dictionary: [String: Any]){
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel"{
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: Any])
        } else{
            super.setValue(value, forKey: key)
        }
    }
    
}
