//
//  LoginViewController.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        navigationController?.navigationBar.isHidden = false
        
        loginView.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        loginView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    @objc fileprivate func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loginView.endEditing(true)
    }
   
    @objc func loginAction(sender: UIButton){
        let email = loginView.emailTextField.text
        let password = loginView.passwordTextField.text
        if checkFields() == true {
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, err) in
                if let err = err {
                    print(err.localizedDescription)
                    ProgressHUD.showError(err.localizedDescription, interaction: true)
                } else {
                    ProgressHUD.showSuccess()
                    self.goToMain()
                }
            }
        } else {
            ProgressHUD.showError("All fields required!", interaction: true)
        }
    }
    
    
    func checkFields() -> Bool{
        let email = loginView.emailTextField.text
        let password = loginView.passwordTextField.text
        
        if email == "" || password == "" {
            return false
        }
        
        return true
    }
    
    func goToMain(){
        let vc = TapBarVC()
        self.show(vc, sender: nil)
    }
    
}
