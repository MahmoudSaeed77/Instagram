//
//  SignUpView.swift
//  Login Firebase Demo
//
//  Created by Mohamed Ibrahem on 11/12/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import ChameleonFramework

class SignUpView: UIView {
    
    
    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ice")?.withRenderingMode(.alwaysOriginal))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 75
        button.clipsToBounds = true
        button.backgroundColor = UIColor.flatWhite
        button.setTitle("Tap to chose Profile Image", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.tintColor = UIColor.red
        return button
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
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.backgroundColor = .clear
        text.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.flatWhite])
        text.layer.borderColor = UIColor.flatWhite.cgColor
        text.isSecureTextEntry = true
        text.autocapitalizationType = UITextAutocapitalizationType.none
        return text
    }()
    
    let firstNameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.backgroundColor = .clear
        text.attributedPlaceholder = NSAttributedString(string: "First name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.flatWhite])
        text.layer.borderColor = UIColor.flatWhite.cgColor
        return text
    }()
    
    
    let lastNameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.backgroundColor = .clear
        text.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.flatWhite])
        text.layer.borderColor = UIColor.flatWhite.cgColor
        return text
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
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
    
    let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        setupView()
        setupConstraints()
        
        
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = UITextField.ViewMode.always
        
        let passwordPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordPadding
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        
        let firstPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        firstNameTextField.leftView = firstPadding
        firstNameTextField.leftViewMode = UITextField.ViewMode.always
        
        let lastPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        lastNameTextField.leftView = lastPadding
        lastNameTextField.leftViewMode = UITextField.ViewMode.always
        
        endEditing(true)
    }
    
    fileprivate func setupView(){
        backgroundColor = FlatWatermelon()
        addSubview(backgroundImage)
        addSubview(avatarButton)
        addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(nameStack)
        nameStack.addArrangedSubview(firstNameTextField)
        nameStack.addArrangedSubview(lastNameTextField)
        fieldsStack.addArrangedSubview(emailTextField)
        fieldsStack.addArrangedSubview(passwordTextField)
        fieldsStack.addArrangedSubview(loginButton)
    }
    
    fileprivate func setupConstraints(){
        NSLayoutConstraint.activate([
            
            backgroundImage.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: heightAnchor),
            
            avatarButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarButton.widthAnchor.constraint(equalToConstant: 150),
            avatarButton.heightAnchor.constraint(equalToConstant: 150),
            
            fieldsStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 250),
            fieldsStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            fieldsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            fieldsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            nameStack.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.15),
            emailTextField.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.15),
            passwordTextField.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.15),
            loginButton.heightAnchor.constraint(equalTo: fieldsStack.heightAnchor, multiplier: 0.15)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
