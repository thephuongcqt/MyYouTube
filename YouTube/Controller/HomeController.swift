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
    
    let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(230, 32, 31)
        return view
    }()
    
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        menuBar.collectionView.reloadData()
    }
    
    //MARK: fetch videos
    
    func fetchVideos(){
        ApiService.shared.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView?.reloadData()
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
        navigationController?.hidesBarsOnSwipe = true
        
        view.addSubview(redView)
        view.addSubview(menuBar)
        //x, y, w, h
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK: handle bar button select
    
    @objc func handleSearch(){
        print(123)
    }
    
    let settingsLauncher = SettingsLauncher()
    
    @objc func handleMore(){
        settingsLauncher.homeController = self
        settingsLauncher.showSettings()
    }
    
    func showController(forSetting setting: Setting){
        let dummySettingsViewController = UIViewController()
        
        dummySettingsViewController.view.backgroundColor = .white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
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

