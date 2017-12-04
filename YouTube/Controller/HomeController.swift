//
//  ViewController.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/4/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Home"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        
        if #available(iOS 11, *){
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.safeWidth
        let videoHeight = (width - 16 - 16) * 9 / 16
        let otherControlsHeight = CGFloat(16 + 16 + 44 + 16)
        let size = CGSize(width: width, height: videoHeight + otherControlsHeight)
        
        return size
    }
}

