//
//  VideoCollectionViewCell.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/4/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank space"
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "TaylorWiftVEVO - 1,604,684,607 vies • 2 years ago"
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        tv.textColor = .lightGray
        return tv
    }()
    
    override func setupViews(){
        backgroundColor = .white
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        //x, y, w, h
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
//        thumbnailImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -16).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        userProfileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        subTitleTextView.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8).isActive = true
        subTitleTextView.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor).isActive = true
        subTitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor).isActive = true
        subTitleTextView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
