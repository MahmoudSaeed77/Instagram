//
//  LoginView.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import ChameleonFramework

class LoginView: UIView {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ice")?.withRenderingMode(.alwaysOriginal))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.backgroundColor = .clear
        text.attributedPlaceholder = NSAttributedString(string: "Email, username...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.flatWhite])
        text.layer.borderColor = UIColor.flatWhite.cgColor
        text.autocapitalizationType = UITextAutocapitalizationType.none
        return text
    }()
    
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.attributedPlaceholder = NSAttributedString(string: "password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.flatWhite])
        text.layer.borderColor = UIColor.flatWhite.cgColor
        text.isSecureTextEntry = true
        text.autocapitalizationType = UITextAutocapitalizationType.none
        return text
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.orange
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    let fieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = UITextField.ViewMode.always
        
        let paddingViewe = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftView = paddingViewe
        passwordTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    fileprivate func setupView(){
        backgroundColor = FlatWatermelon()
        addSubview(backgroundImage)
        addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(emailTextField)
        fieldsStack.addArrangedSubview(passwordTextField)
        fieldsStack.addArrangedSubview(loginButton)
    }
    
    fileprivate func setupConstraints(){
        NSLayoutConstraint.activate([
            
            backgroundImage.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: heightAnchor),
            
            fieldsStack.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            fieldsStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            fieldsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            fieldsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            emailTextField.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.2),
            passwordTextField.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.2),
            loginButton.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.2)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
