# TotalObserver

[![Version](https://img.shields.io/cocoapods/v/TotalObserver.svg?style=flat)](http://cocoapods.org/pods/TotalObserver)
[![License](https://img.shields.io/cocoapods/l/TotalObserver.svg?style=flat)](http://cocoapods.org/pods/TotalObserver)
[![Platform](https://img.shields.io/cocoapods/p/TotalObserver.svg?style=flat)](http://cocoapods.org/pods/TotalObserver)

A simplified Objective-C API for using NSNotifications and KVO with consistent terminology and useful convenience features.

Uses blocks exclusively, but unlike NSNotification's blocks API, allows removal using matching parameters instead of requiring storage of an observation object. Supports automatic removal when either observer or observee is deallocated. Can optionally omit the “to_” prefix on all the category methods.

Extensible to other styles of observers, an included example is a wrapper for UIControl event actions.

TotalObserver's feature set is heavily influenced by [MAKVONotificationCenter](http://github.com/mikeash/MAKVONotificationCenter), and also adapts its rock-solid solution for automatic removal.

Written in Objective-C but tested to be usable from Swift.

Pull requests welcome.

## Usage

```objective-c
#import <TotalObserver/TotalObserver.h>

TOObservation *o1 = [self to_observeForChanges:object toKeyPath:@"name" withBlock:^(ViewController *obj, TOKVOObservation *obs) {
    // first parameter is the observer passed back, which in the common case is self
    // prevents you from having to create a weak self pointer yourself
    [obj handleNameChange];
}];
[o1 remove];
// or do nothing and observation is removed automatically when observer is deallocated
// no need to add any code to -dealloc method

[self to_observeForChanges:object toKeyPath:@"name" withBlock:^(id obj, TOKVOObservation *obs) {
    // observation object has properties for direct access to new and old values
    // all the standard keys from the change dictionary
}];
[self to_stopObservingForChanges:object toKeyPath:@"name"];

[object to_observeChangesToKeyPaths:@[@"name", @"flag"] withBlock:^(TOKVOObservation *obs) {
    // observe many keys at once, easily detect which one it was
    if ([obs.keyPath isEqualToString:@"flag"])
    	;
    // note: this API omits observer, this block may outlive the object whose method made this call!
}];
object = nil; // observation is also removed automatically when target of observation is deallocated

[self to_observeForNotifications:object named:ObjectUpdatedNotification withBlock:^(id obj, TONotificationObservation *obs) {
    // easy access to the notification's properties
    NSLog(@"%@", obs.postedObject, obs.userInfo);
}];
[self to_observeNotificationsNamed:SomethingOccurredNotification withBlock:^(TONotificationObservation *obs) {
    // exhaustive combinations of methods, eg. for posts by any object
    // object parameter is omitted rather than requiring you to pass object:nil
}];

// extended with wrapper for UIControl event actions
// can be easily extended to other flavor of observers too, with same autoremoval behavior
[self to_observeControlForPress:self.button withBlock:^(id obj, TONotificationObservation *obs) {
}];
[self.field to_observeEvents:UIControlEventEditingDidBegin withBlock:^(TOObservation *obs) {
}];
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TotalObserver is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TotalObserver"
```

Alternately, you can enable shorthand methods that leave the `to_` prefix off the catgory method names (inspired by MagicalRecord) by instead adding to your Podfile:

```ruby
pod "TotalObserver/Shorthand"
```

and also, somewhere in your app's launching process, such as a `+load` method or your app delegate's `application:didFinishLaunching...` method, add this class method call:

```objective-c
[TOObservation setupShorthandMethods];
```

#### Running Example

If using `pod try` or manually cloning the source to try out the Example app, first cd into its directory and execute `pod install`, then as directed open `TotalObserver.xcworkspace` and not the `.xcodeproj` file.


## Author

Pierre Houston, jpmhouston@gmail.com

## License

TotalObserver is available under the MIT license. See the LICENSE file for more info.
