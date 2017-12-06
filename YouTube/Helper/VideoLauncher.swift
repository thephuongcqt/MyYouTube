//
//  VideoLauncher.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/6/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
   
    func showVideoPlayer(with controller: UIViewController){
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            var y = CGFloat(0)
            if #available(iOS 11, *){
                y += controller.view.safeAreaInsets.top
            }
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: y, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (success) in
//                UIApplication.setStattusBarBackground(color: .black)
//                controller.prefersStatusBarHidden =
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
