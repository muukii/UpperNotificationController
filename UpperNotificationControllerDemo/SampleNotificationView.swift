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
    
    func didPrepare(dismissClosure: () -> Void) {
        
        let delay = 2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            
            dismissClosure()
            })
    }
    
    func willAppear() {
        print("[NotificationView] willAppear")
    }
    
    func didAppear() {
        print("[NotificationView] didAppear")
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
