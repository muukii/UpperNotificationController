//
//  SampleNotificationAnomator.swift
//  UpperNotificationController
//
//  Created by muukii on 7/5/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit
import UpperNotificationController

struct Animator: UpperNotificationAnimatorType {
    
    func applyPresentAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void) {
        
        notificationView.layer.transform = CATransform3DMakeTranslation(0, -notificationView.bounds.height, 0)

        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.layer.transform = CATransform3DIdentity

            }) { (finish) in
                
                completion()
        }
    }
    
    func applyDismissAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void) {
                        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.layer.transform = CATransform3DMakeTranslation(0, -notificationView.bounds.height, 0)
            
        }) { (finish) in
            
            completion()
        }
    }
}