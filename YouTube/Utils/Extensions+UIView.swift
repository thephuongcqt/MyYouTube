//
//  Extensions+UIView.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/4/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.leadingAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.trailingAnchor
        }else {
            return self.trailingAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    var safeBottomPadding: CGFloat{
        if #available(iOS 11, *){
            return self.safeAreaInsets.bottom
        }
        return 0
    }
    
    var safeTopPadding: CGFloat{
        if #available(iOS 11, *){
            return self.safeAreaInsets.top
        }
        return 0
    }
    
    var safeLeftPadding: CGFloat{
        if #available(iOS 11, *){
            return self.safeAreaInsets.left
        }
        return 0
    }
    var safeRightPadding: CGFloat{
        if #available(iOS 11, *){
            return self.safeAreaInsets.right
        }
        return 0
    }
    
    var safeWidth: CGFloat{
        if #available(iOS 11, *){
            return self.safeAreaLayoutGuide.layoutFrame.width
        }
        return self.frame.width
    }
    var safeHeight: CGFloat{
        if #available(iOS 11, *){
            return self.safeAreaLayoutGuide.layoutFrame.height
        }
        return self.frame.height
    }
}
