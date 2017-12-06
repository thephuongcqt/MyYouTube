//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/6/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.shared.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
