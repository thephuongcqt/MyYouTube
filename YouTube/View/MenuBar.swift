//
//  MenuBar.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/5/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 230, g: 32, b: 31)
        
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let images = [#imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "trending"), #imageLiteral(resourceName: "subscriptions"), #imageLiteral(resourceName: "account")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(r: 230, g: 32, b: 31)
        addSubview(collectionView)
        
        //x, y, w, y
        collectionView.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.safeTrailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuCell
        cell.imageView.image = images[indexPath.item].withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(r: 91, g: 14, b: 13)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.safeWidth / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
