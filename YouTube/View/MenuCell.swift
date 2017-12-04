//
//  MenuCollectionViewCell.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/5/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "home")
//        iv.tintColor = UIColor(r: 91, g: 14, b: 13)
        return iv
    }()
    
    override func setupViews() {
        addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? .white : UIColor(r: 91, g: 14, b: 13)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? .white : UIColor(r: 91, g: 14, b: 13)
        }
    }
}
