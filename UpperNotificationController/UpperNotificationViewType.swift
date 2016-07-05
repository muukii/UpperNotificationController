//
//  UpperNotificationViewType.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation

public protocol UpperNotificationViewType: class {
    
    // MARK: - Behavior
    
    var duration: NSTimeInterval { get }
    var shouldDismiss: Bool { get }
    
    // MARK: - LifeCycle
    
    func didPrepare(manualDismissClosure: () -> Void)
    
    func willAppear()
    func didAppear()
    
    func willDisappear()
    func didDisappear()
}
