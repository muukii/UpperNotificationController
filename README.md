# UpperNotificationController

[![CI Status](http://img.shields.io/travis/muukii/UpperNotificationController.svg?style=flat)](https://travis-ci.org/muukii/UpperNotificationController)
[![Version](https://img.shields.io/cocoapods/v/UpperNotificationController.svg?style=flat)](http://cocoapods.org/pods/UpperNotificationController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/UpperNotificationController.svg?style=flat)](http://cocoapods.org/pods/UpperNotificationController)
[![Platform](https://img.shields.io/cocoapods/p/UpperNotificationController.svg?style=flat)](http://cocoapods.org/pods/UpperNotificationController)

## Usage

### 1. Create UIView of UpperNotificationViewType

```swift
class MyNotification: UpperNotificationViewType {

    func didPrepare(manualDismissClosure: () -> Void)

    func willAppear()
    func didAppear()

    func willDisappear()
    func didDisappear()
}
```

### 2. Create class or struct of UpperNotificationAnimatorType

```swift
public protocol UpperNotificationAnimatorType {

    func applyPresentAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void)

    func applyDismissAnimation<T where T: UpperNotificationViewType, T: UIView>(notificationView notificationView: T, completion: () -> Void)
}

struct MyAnimator: UpperNotificationViewType { ... }
```

### 3. Create UpperNotificationController

```swift
let notificationController = UpperNotificationController()
```

### 4. Deliver notification

```swift

let notification = NotificationReservation<SampleNotificationView> {
    SampleNotificationView()
}

notificationController.deliver(notification: notification, animator: Animator())
```

## Requirements

iOS 8.0+

## Installation
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build UpperNotificationController

To integrate UpperNotificationController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'UpperNotificationController'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate UpperNotificationController into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "muukii/UpperNotificationController"
```

Run `carthage update` to build the framework and drag the built `UpperNotificationController.framework` into your Xcode project.


## Author

muukii, m@muukii.me

## License

UpperNotificationController is available under the MIT license. See the LICENSE file for more info.
