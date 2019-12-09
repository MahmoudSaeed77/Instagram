//
//  LoginViewController.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        navigationController?.navigationBar.isHidden = false
        
        loginView.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func loginAction(sender: UIButton){
        let email = loginView.emailTextField.text
        let password = loginView.passwordTextField.text
        if checkFields() == true {
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, err) in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    self.goToMain()
                }
            }
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
        let navController = UINavigationController(rootViewController: vc)
        self.dismiss(animated: true, completion: nil)
        navigationController?.present(navController, animated: true, completion: nil)
        
//        var window = UIApplication.shared.keyWindow
//        window = UIWindow()
//        window?.makeKeyAndVisible()
//        window?.rootViewController = TapBarVC()
        
    }
    
}
