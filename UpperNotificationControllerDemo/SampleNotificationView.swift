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

    func didPrepare(_ dismissClosure: @escaping () -> Void) {
        
        let delay = 2 * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            
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
        return UINib(nibName: "SampleNotificationView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SampleNotificationView
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    deinit {
        print("deinit \(self)")
    }

}
