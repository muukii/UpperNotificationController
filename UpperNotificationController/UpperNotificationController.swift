//
//  UpperNotificationController.swift
//  UpperNotificationController
//
//  Created by muukii on 7/4/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

open class UpperNotificationController {
    
    // MARK: - Public
    
    open var windowLevel: UIWindowLevel {
        get {
            return notificationWindow.windowLevel
        }
        set {
            notificationWindow.windowLevel = newValue
        }
    }
    
    public init() {
        notificationWindow.windowLevel = 3
        notificationWindow.isHidden = true
        notificationWindow.backgroundColor = UIColor.clear
        notificationWindow.frame = UIScreen.main.bounds
        notificationViewController.beginAppearanceTransition(true, animated: false)
        notificationWindow.rootViewController = notificationViewController
        notificationViewController.endAppearanceTransition()
    }
    
    open func deliver<T>(notification: NotificationContext<T>, animator: UpperNotificationAnimatorType) where T: UpperNotificationViewType, T: UIView {
        
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
            
            let keyWindow = UIApplication.shared.keyWindow
            self.notificationWindow.isHidden = false
            self.notificationWindow.makeKeyAndVisible()
            self.notificationViewController.addNotificationView(notificationView: notification.factory(), animator: animator) { [weak self] view in
                
                keyWindow?.makeKeyAndVisible()
                self?.notificationWindow.isHidden = true
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
    fileprivate var closureQueue: [() -> Void] = []
    fileprivate let notificationWindow: NotificationWindow = NotificationWindow()
    fileprivate let notificationViewController: NotificationViewController = NotificationViewController()
    
    
    // MARK: - Private Classes
    
    fileprivate class NotificationWindow: UIWindow {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            isOpaque = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            
            let view = super.hitTest(point, with: event)
            
            if view == self {
                
                return nil
            }
            return view
        }
    }
    
    fileprivate class NotificationViewController: UIViewController {
        
        fileprivate override func loadView() {
            self.view = View()
        }
        
        fileprivate override func viewDidLoad() {
            super.viewDidLoad()
            view.isOpaque = false
            view.backgroundColor = UIColor.clear
        }
        
        var hasNotificationView: Bool {
            return view.subviews.count > 0
        }
        
        func addNotificationView<T>(notificationView: T, animator: UpperNotificationAnimatorType, completion: @escaping (T) -> Void) where T: UpperNotificationViewType, T: UIView {
            
            guard view.subviews.count == 0 else {
                assertionFailure("It is necessary to remove the old notification view, Check with hasNotificationView")
                return
            }
            
            notificationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(notificationView)
            
            let top = NSLayoutConstraint(
                item: notificationView,
                attribute: .top,
                relatedBy: .equal,
                toItem: view,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
            
            let left = NSLayoutConstraint(
                item: notificationView,
                attribute: .left,
                relatedBy: .equal,
                toItem: view,
                attribute: .left,
                multiplier: 1,
                constant: 0
            )
            
            let right = NSLayoutConstraint(
                item: notificationView,
                attribute: .right,
                relatedBy: .equal,
                toItem: view,
                attribute: .right,
                multiplier: 1,
                constant: 0
            )
            
            NSLayoutConstraint.activate([top, left, right])
            
            notificationView.layoutIfNeeded()
            
            let size = notificationView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
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
        
        func removeNotificationView<T>(notificationView: T, animator: UpperNotificationAnimatorType, completion: @escaping (T) -> Void) where T: UpperNotificationViewType, T: UIView {
            
            removeNotificationViewClosure(notificationView: notificationView, animator: animator, completion: completion)()
        }
        
        fileprivate func removeNotificationViewClosure<T>(notificationView: T, animator: UpperNotificationAnimatorType, completion: @escaping (T) -> Void) -> () -> Void where T: UpperNotificationViewType, T: UIView {
            
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
        fileprivate class View: UIView {
            override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
                
                let view = super.hitTest(point, with: event)
                
                if view == self {
                    
                    return nil
                }
                return view
            }
        }
    }
    
}
