//
//  FeedCell.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/6/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var videos: [Video]?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        
        fetchVideos()
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: fetch videos
    
    func fetchVideos(){
        ApiService.shared.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    //MARK: UICollectionViewController method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.safeWidth
        //estimate height base on title label height
        let otherControlsHeight = CGFloat(16 + 16 + 44 + 16 + 24)
        
        //        if let title = videos[indexPath.item].title{
        //            let estimateWidth = width - 16 - 44 - 8 - 16
        //            let estimateRect = title.estimateCGrect(withConstrainedWidth: estimateWidth, font: UIFont.systemFont(ofSize: 14))
        //            otherControlsHeight += CGFloat(estimateRect.height > 20 ? 24 : 0)
        //        }
        
        let videoHeight = (width - 16 - 16) * 9 / 16
        let size = CGSize(width: width, height: (videoHeight + otherControlsHeight))
        return size
    }

}
