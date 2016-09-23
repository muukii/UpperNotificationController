//
//  ViewController.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit
import UpperNotificationController

class ViewController: UIViewController {
    
    let notification = UpperNotificationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func show(_ sender: AnyObject) {
        let n = NotificationContext<SampleNotificationView> {
            SampleNotificationView.viewFromNib()
        }
        notification.deliver(notification: n, animator: Animator())                
    }
}

