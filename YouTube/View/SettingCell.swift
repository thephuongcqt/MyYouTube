//
//  SettingCell.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/5/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
//    override var isSelected: Bool{
//        didSet{
//            backgroundColor = isSelected ? .darkGray : .white
//            nameLabel.textColor = isSelected ? .white : .black
//            iconImageView.tintColor = isSelected ? .white : .darkGray
//        }
//    }
    
    var setting: Setting?{
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName, let image = UIImage(named: imageName){
                
                iconImageView.image = image.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "settings")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.safeTrailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.safeBottomAnchor).isActive = true
        
        iconImageView.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor, constant: 16).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
