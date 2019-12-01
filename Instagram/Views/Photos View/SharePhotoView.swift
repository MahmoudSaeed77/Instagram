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
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.flatPlum
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let captionTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    fileprivate func setupView() {
        backgroundColor = UIColor.white
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(captionTextView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.widthAnchor.constraint(equalToConstant: 84),
            imageView.heightAnchor.constraint(equalToConstant: 84),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            captionTextView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            captionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            captionTextView.heightAnchor.constraint(equalToConstant: 84),
            captionTextView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
