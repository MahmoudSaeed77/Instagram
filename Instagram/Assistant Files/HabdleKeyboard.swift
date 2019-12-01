//
//  HabdleKeyboard.swift
//  Mapper
//
//  Created by Mohamed Ibrahem on 7/31/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func HabdleKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardConfigration), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardConfigration(notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
    
    
}
