//
//  UpperNotificationViewType.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation

public protocol UpperNotificationViewType: class {
        
    // MARK: - LifeCycle
    
    /**
     - parameter manualDismissClosure: Call this closure to dismiss the notification view
     */
    func didPrepare(dismissClosure: () -> Void)
    
    func willAppear()
    func didAppear()
    
    func willDisappear()
    func didDisappear()
}
