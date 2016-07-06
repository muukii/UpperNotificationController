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
    
    func didPrepare(manualDismissClosure: () -> Void)
    
    func willAppear()
    func didAppear()
    
    func willDisappear()
    func didDisappear()
}
