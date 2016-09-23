//
//  NotificationReservertion.swift
//  UpperNotificationController
//
//  Created by muukii on 7/6/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation

open class NotificationContext<T> where T: UpperNotificationViewType, T: UIView {
    
    open let factory: () -> T
    open var cancel: Bool = false
    
    public init(factory: @escaping () -> T) {
        self.factory = factory
    }
}
