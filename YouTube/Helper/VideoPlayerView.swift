//
//  VideoPlayer.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/7/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//
import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderchange), for: .valueChanged)
        return slider
    }()
    
    //MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(pausePlayButton)
        controlsContainerView.addSubview(activityIndicatorView)
        
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(videoSlider)
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        videoLengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        videoSlider.trailingAnchor.constraint(equalTo: videoLengthLabel.leadingAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30)
        backgroundColor = .black
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setup player
    
    func setupPlayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/chatmessenger-b5a6e.appspot.com/o/bunny.mp4?alt=media&token=73fa3b6a-1ec8-465a-815d-50a9633cbed3"
        if let url = URL(string: urlString){
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            //            isPlaying = true
            pausePlayButton.isHidden = false
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            
            if let duration = player?.currentItem?.duration{
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }        }
    }
    
    //MARK: handle event
    
    var isPlaying = true
    
    @objc func handlePause(){
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else{
            player?.play()
            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc func handleSliderchange(){
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //tada
            })
        }
    }
}
