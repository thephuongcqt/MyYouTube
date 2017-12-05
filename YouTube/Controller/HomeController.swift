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
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
//    let videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 239843093
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 597843543
//
//        var newVideo = Video()
//        newVideo.title = "Taylor Swift - Bad Blood featuring Kendrick dick head"
//        newVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        newVideo.channel = kanyeChannel
//        newVideo.numberOfViews = 597843543
//
//        return [blankSpaceVideo, newVideo, badBloodVideo, newVideo]
//    }()
    var videos: [Video]?
    
    //MARK: UIViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        
        if #available(iOS 11, *){
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        setupNavBarButtons()
    }
    
    //MARK: fetch videos
    
    func fetchVideos(){
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                do{
                    self.videos = [Video]()
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    for dictionary in json as! [[String: Any]]{
                        let video = Video(withDictionary: dictionary)
                        self.videos?.append(video)
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                } catch let err{
                    print(err)
                }
            }.resume()
        }
        
    }
    
    //MARK: Set up Navigation Bar
    
    private func setupNavBarButtons(){
        let searchImage = #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreImage = #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems =  [moreButton, searchBarButtonItem]
    }
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        //x, y, w, h
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK: handle bar button select
    
    @objc func handleSearch(){
        print(123)
    }
    
    let settingsLauncher = SettingsLauncher()
    
    @objc func handleMore(){
        settingsLauncher.showSettings()
    }
    
    
    // MARK: UICollectionView method
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.safeWidth
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

