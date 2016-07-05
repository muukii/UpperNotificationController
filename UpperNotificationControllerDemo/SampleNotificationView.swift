//
//  SampleNotificationView.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit
import UpperNotificationController

final class SampleNotificationView: UIView, UpperNotificationViewType {
    
    var manualDismissClosure: (() -> Void)?
    
    var shouldDismiss: Bool {
        print("[NotificationView] shouldDismiss")
        return true
    }
    
    func didPrepare(manualDismissClosure: () -> Void) {
        self.manualDismissClosure = manualDismissClosure
    }
    
    var duration: NSTimeInterval {
        print("[NotificationView] duration")
        return 2
    }
    
    func willAppear() {
        print("[NotificationView] willAppear")
    }
    
    func didAppear() {
        print("[NotificationView] didAppear")
        
        self.manualDismissClosure?()
    }
    
    func willDisappear() {
        print("[NotificationView] willDisappear")
    }
    
    func didDisappear() {
        print("[NotificationView] didDisAppear")
    }
    
    class func viewFromNib() -> SampleNotificationView {
        return UINib(nibName: "SampleNotificationView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! SampleNotificationView
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    deinit {
        print("deinit \(self)")
    }

}
