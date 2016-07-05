//
//  NotificationReservertion.swift
//  UpperNotificationController
//
//  Created by muukii on 7/6/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation

public class NotificationReservation<T where T: UpperNotificationViewType, T: UIView> {
    
    public let factory: () -> T
    public var cancel: Bool = false
    
    public init(factory: () -> T) {
        self.factory = factory
    }
}
