//
//  SignUpViewController.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class SignUpViewController: UIViewController {
    
    let signupView = SignUpView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signupView
        
        signupView.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        signupView.avatarButton.addTarget(self, action: #selector(avatarAction), for: .touchUpInside)
        signupView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
    }
    
    @objc fileprivate func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func loginAction(sender: UIButton){
        
        ProgressHUD.show()
        let db = Database.database().reference()
        let storage = Storage.storage().reference()
        guard let firstName = signupView.firstNameTextField.text else {return}
        guard let lastName = signupView.lastNameTextField.text else {return}
        guard let email = signupView.emailTextField.text else {return}
        guard let password = signupView.passwordTextField.text else {return}
        
        
        
        if checkFields() == true {
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    print(err?.localizedDescription as Any)
                } else {
                    guard let image = self.signupView.avatarButton.imageView?.image else {return}
                    guard let uploadImage = image.jpegData(compressionQuality: 0.3) else {return}
                    let fileName = NSUUID().uuidString
                    storage.child("profileImages").child(fileName).putData(uploadImage, metadata: nil, completion: { (metaData, err) in
                        if let err = err {
                            print("Error uploading profile image \(err)")
                            ProgressHUD.showError(err.localizedDescription)
                        }
                        print("seccess uploading profile image")
                        
                        // for download image url
                        let starsRef = storage.child("profileImages").child(fileName)
                        starsRef.downloadURL { url, error in
                            if let error = error {
                                print("error getting url \(error)")
                                ProgressHUD.showError(error.localizedDescription)
                            } else {
                                // for adding values to database
                                guard let uid = Auth.auth().currentUser?.uid else {return}
                                guard let imageUrl = url?.absoluteString else {return}
                                let nameInfo = [
                                    "firstName": firstName,
                                    "lastName": lastName,
                                    "imageUrl": imageUrl,
                                    "uid": uid
                                    ]
                                guard let id = result?.user.uid else {return}
                                let values = [
                                    id : nameInfo
                                ]
                                db.child("users").updateChildValues(values, withCompletionBlock: { (err, refernce) in
                                    if err != nil {
                                        print("Error adding name fields: \(String(describing: err))")
                                        ProgressHUD.showError(err?.localizedDescription)
                                    } else {
                                        print("Success adding name fields")
                                    }
                                })
                            }
                        }
                        ProgressHUD.dismiss()
                        ProgressHUD.showSuccess()
                        
                        self.goToMain()

                    })
                    
                    }
            }
        } else {
            ProgressHUD.showError("All fields required!", interaction: true)
        }
    }
    
    
    func checkFields() -> Bool{
        let firstName = signupView.firstNameTextField.text
        let lastName = signupView.lastNameTextField.text
        let email = signupView.emailTextField.text
        let password = signupView.passwordTextField.text
        
        if firstName == "" || lastName == "" || email == "" || password == "" {
            return false
        }
        
        return true
    }
    
    func goToMain(){
        let vc = TapBarVC()
        self.show(vc, sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.signupView.endEditing(true)
    }
    
    @objc func avatarAction(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage =  info[.originalImage] as? UIImage {
            signupView.avatarButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if let editedImage = info[.editedImage] as? UIImage {
            signupView.avatarButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
