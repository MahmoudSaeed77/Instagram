//
//  ViewController.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/11/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class StartController: UIViewController {
    let startView = StartView()
    let cellId = "cellId"
    let images = [
        UIImage(named: "2-1"),
        UIImage(named: "4-1"),
        UIImage(named: "3-1"),
    ]
    var timer:Timer?
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view = startView
        startView.collectionView.delegate = self
        startView.collectionView.dataSource = self
        startView.collectionView.register(SliderCell.self, forCellWithReuseIdentifier: cellId)
        startView.pageController.numberOfPages = images.count
        startTimer()
        addTargets()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
    }
    @objc func timeAction(){
        startView.pageController.currentPage = currentIndex
        if currentIndex == images.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        startView.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        startView.pageController.currentPage = currentIndex
    }
    
    func addTargets(){
        startView.loginButton.addTarget(self, action: #selector(Action), for: .touchUpInside)
        startView.signupButton.addTarget(self, action: #selector(Action), for: .touchUpInside)
    }
    
    @objc func Action(sender: UIButton){
        var vc: UIViewController!
        if sender.currentTitle == "Login" {
            vc = LoginViewController()
        }else if sender.currentTitle == "Signup"{
            vc = SignUpViewController()
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension StartController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: startView.collectionView.frame.width, height: startView.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SliderCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}
