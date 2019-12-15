//
//  SharePhotoView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/24/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import ChameleonFramework

class SharePhotoView: UIView {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let captionTextView: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor.black
        text.font = UIFont.systemFont(ofSize: 16)
        text.placeholder = "type your caption here..."
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    fileprivate func setupView() {
        backgroundColor = UIColor.white
        
        addSubview(captionTextView)
        addSubview(imageView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            captionTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            captionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            captionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            captionTextView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            
            
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
