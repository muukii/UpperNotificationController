//
//  UpperNotificationController.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

public class UpperNotificationController {
    
    // MARK: - Public
    
    public var windowLevel: UIWindowLevel {
        get {
            return notificationWindow.windowLevel
        }
        set {
            notificationWindow.windowLevel = newValue
        }
    }
    
    public init() {
        notificationWindow.windowLevel = 3
        notificationWindow.backgroundColor = UIColor.clearColor()
        notificationWindow.frame = UIScreen.mainScreen().bounds
        notificationViewController.beginAppearanceTransition(true, animated: false)
        notificationWindow.rootViewController = notificationViewController
        notificationViewController.endAppearanceTransition()
    }
    
    public func deliver<T where T: UpperNotificationViewType, T: UIView>(notification notification: NotificationReservation<T>, animator: UpperNotificationAnimatorType) {
        
        closureQueue.append({ [weak self] in
            guard let `self` = self else { return }
            
            let next: () -> Void = { [weak self] in
                
                guard let `self` = self else { return }
                
                if self.closureQueue.isEmpty == false {
                    let closure = self.closureQueue.removeFirst()
                    closure()
                }
            }
            
            guard notification.cancel == false else {
                next()
                return
            }
            
            let keyWindow = UIApplication.sharedApplication().keyWindow
            self.notificationWindow.makeKeyAndVisible()
            self.notificationViewController.addNotificationView(notificationView: notification.factory(), animator: animator) { view in
                
                keyWindow?.makeKeyAndVisible()
                next()
            }
            })
        
        if notificationViewController.hasNotificationView == false {
            // Deliver immediately

            if self.closureQueue.isEmpty == false {
                let closure = self.closureQueue.removeFirst()
                closure()
            }
        }
    }
    
    
    // MARK: - Private
    private var closureQueue: [() -> Void] = []
    private let notificationWindow: NotificationWindow = NotificationWindow()
    private let notificationViewController: NotificationViewController = NotificationViewController()
    
    
    // MARK: - Private Classes
    
    private class NotificationWindow: UIWindow {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            opaque = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
            
            let view = super.hitTest(point, withEvent: event)
            
            if view == self {
                
                return nil
            }
            return view
        }
    }
    
    private class NotificationViewController: UIViewController {
        
        private override func loadView() {
            self.view = View()
        }
        
        private override func viewDidLoad() {
            super.viewDidLoad()
            view.opaque = false
            view.backgroundColor = UIColor.clearColor()
        }
        
        var hasNotificationView: Bool {
            return view.subviews.count > 0
        }
        
        func addNotificationView<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, animator: UpperNotificationAnimatorType, completion: T -> Void) {
            
            guard view.subviews.count == 0 else {
                assertionFailure("It is necessary to remove the old notification view, Check with hasNotificationView")
                return
            }
            
            notificationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(notificationView)
            
            let top = NSLayoutConstraint(
                item: notificationView,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Top,
                multiplier: 1,
                constant: 0
            )
            
            let left = NSLayoutConstraint(
                item: notificationView,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Left,
                multiplier: 1,
                constant: 0
            )
            
            let right = NSLayoutConstraint(
                item: notificationView,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Right,
                multiplier: 1,
                constant: 0
            )
            
            NSLayoutConstraint.activateConstraints([top, left, right])
            
            let size = notificationView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            if size.height == 0 || size.width == 0 {
                assertionFailure("NotificationView will not be appear.")
            }
            
            notificationView.didPrepare(removeNotificationViewClosure(notificationView: notificationView, animator: animator, completion: completion))
            
            notificationView.willAppear()
            
            animator.applyPresentAnimation(notificationView: notificationView) { [weak notificationView] in
                
                guard let notificationView = notificationView else {
                    return
                }
                
                notificationView.didAppear()
            }
        }
        
        func removeNotificationView<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, animator: UpperNotificationAnimatorType, completion: T -> Void) {
            
            removeNotificationViewClosure(notificationView: notificationView, animator: animator, completion: completion)()
        }
        
        private func removeNotificationViewClosure<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, animator: UpperNotificationAnimatorType, completion: T -> Void) -> () -> Void {
            
            return { [weak notificationView] in
                
                guard let notificationView = notificationView else {
                    // Already dismissed.
                    return
                }
                
                guard notificationView.window != nil else {
                    // Already dismissed.
                    return
                }
                
                notificationView.willDisappear()
                
                animator.applyDismissAnimation(notificationView: notificationView) { [weak notificationView] in
                    
                    guard let notificationView = notificationView else { return }
                    
                    notificationView.didDisappear()
                    notificationView.removeFromSuperview()
                    completion(notificationView)
                }
            }
        }
        
        // MARK: - Private Class
        private class View: UIView {
            override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
                
                let view = super.hitTest(point, withEvent: event)
                
                if view == self {
                    
                    return nil
                }
                return view
            }
        }
    }
    
}
