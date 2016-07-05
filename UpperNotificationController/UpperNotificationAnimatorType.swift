//
//  UpperNotificationAnimatorType.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

public protocol UpperNotificationAnimatorType {
        
    func applyPresentAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void)
    
    func applyDismissAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void)
}

extension UpperNotificationAnimatorType {
    public var statusBarWindow: UIWindow {
        return UIApplication.sharedApplication().valueForKey("_statusBarWindow") as! UIWindow
    }
}
