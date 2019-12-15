//
//  CommentView.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 12/2/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class CommentView: UIView, UITextViewDelegate {
    
    let separetorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let commentTextfield: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 16)
        return text
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Comment", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textColor = UIColor.blue
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceVertical = true
        layout.scrollDirection = .vertical
        collection.backgroundColor = #colorLiteral(red: 0.9289736675, green: 0.9289736675, blue: 0.9289736675, alpha: 1)
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.flatWhite
        commentTextfield.delegate = self
        commentTextfield.text = "Type a comment..."
        commentTextfield.textColor = UIColor.lightGray
        addSubview(collectionView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        } else {
            textView.textColor = UIColor.lightGray
            textView.text = "Type a comment..."
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type a comment..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
