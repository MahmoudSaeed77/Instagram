//
//  SharePhotoController.swift
//  Instagram
//
//  Created by Mohamed Ibrahem on 11/24/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class SharePhotoController: UIViewController {
    let shareView = SharePhotoView()
    var selectedImage: UIImage? {
        didSet {
            self.shareView.imageView.image = selectedImage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view = shareView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareAction))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.shareView.endEditing(true)
    }
    
    @objc func shareAction() {
        resignFirstResponder()
        ProgressHUD.show()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let fileName = NSUUID().uuidString
        
        guard let image = selectedImage else {return}
        guard let uploadedData = image.jpegData(compressionQuality: 0.5) else {return}
        
        let storageRef = Storage.storage().reference().child("postImages").child(fileName)
            
            storageRef.putData(uploadedData, metadata: nil) { (metaData, err) in
            if let err = err {
                print("upload post image error:", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("successfully uploaded post image")
            
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print("download post image url error:", err)
                        return
                    }
                    
                    guard let imageUrl = url?.absoluteString else {return}
                    self.savePostInfo(imageUrl: imageUrl)
                })
            
        }
    }
    
    fileprivate func savePostInfo(imageUrl: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let caption = shareView.captionTextView.text else {return}
        guard let image = selectedImage else {return}
        let databaseRef = Database.database().reference().child("posts").child(uid)
        let ref = databaseRef.childByAutoId()
        let values = [
            "imageUrl": imageUrl,
            "caption": caption,
            "postDate": Date().timeIntervalSince1970,
            "imageWidth": image.size.width,
            "imageHeight": image.size.height
        ] as [String:Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("error adding post informations to database:", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("successfully adding post informations")
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            ProgressHUD.dismiss()
            ProgressHUD.showSuccess()
            self.dismiss(animated: true, completion: nil)
            let name = NSNotification.Name(rawValue: "loadPosts")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
}
