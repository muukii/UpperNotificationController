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

    func applyPresentAnimation<T>(notificationView: T, completion: @escaping () -> Void) where T: UpperNotificationViewType, T: UIView {
        
        notificationView.layer.transform = CATransform3DMakeTranslation(0, -notificationView.bounds.height, 0)

        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.layer.transform = CATransform3DIdentity

            }) { (finish) in
                
                completion()
        }
    }
    
    func applyDismissAnimation<T>(notificationView: T, completion: @escaping () -> Void) where T: UpperNotificationViewType, T: UIView {
                        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            
            notificationView.layer.transform = CATransform3DMakeTranslation(0, -notificationView.bounds.height, 0)
            
        }) { (finish) in
            
            completion()
        }
    }
}
