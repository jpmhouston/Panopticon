# Panopticon

[![Version](https://img.shields.io/cocoapods/v/Panopticon.svg?style=flat)](http://cocoapods.org/pods/Panopticon)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Panopticon.svg?style=flat)](http://cocoapods.org/pods/Panopticon)
[![Platform](https://img.shields.io/cocoapods/p/Panopticon.svg?style=flat)](http://cocoapods.org/pods/Panopticon)

A simplified Objective-C API for using NSNotifications and KVO with consistent terminology and useful convenience features.

Uses blocks exclusively, but unlike NSNotification's blocks API, allows removal using matching parameters instead of requiring storage of an observation object. Supports automatic removal when either observer or observee is deallocated. Can optionally omit the “pan_” prefix on all the category methods.

Extensible to other styles of observers, included are a wrapper for UIControl event actions, and another for darwin notifications across app groups.

Panopticon's feature set is heavily influenced by [MAKVONotificationCenter](https://github.com/mikeash/MAKVONotificationCenter), and also adapts its rock-solid solution for automatic removal. Inspiration for app groups notifications comes from [MMWormhole](https://github.com/mutualmobile/MMWormhole).

Written in Objective-C but tested to verify it's usable from Swift.

Most every external classes, properties, methods are documented, but could very well do with some proofreading and improvements. Attempts to build documentation using [jazzy](https://github.com/realm/jazzy) are currently blocked by its [issue #158](https://github.com/realm/jazzy/issues/518), sadly.

Pull requests welcome.

## Usage

Import using either `#import <Panopticon/Panopticon.h>` or `@import Panopticon;`.

There are 2 general styles of observing methods, one where you pass in an observer (often self), and another where you omit the observer for brevity when its unnecessary. In both cases, the final block parameter is called when the observation is triggered.

You can do nothing and observation is removed automatically when either your observer or the observed object is deallocated. No need to add remove code to `dealloc`, no need to keep the `PANObservation` result from the observe method.

If you want to explicitly remove an observation, you can keep the observe method's result after all and call `remove` on it. But you can also use a `stopObserving` class method, which (like `-[NSNotificationCenter removeObserver:name:object:]`) you call with a repeat of that the same parameters as you the passed to `observe`, and the correct observation will be found and removed.

```objective-c
PANObservation *o1 = [self pan_observeForChanges:object toKeyPath:@"name" withBlock:^(id obj, PANKeyValueObservation *obs) {
    NSLog(@"observed change to object's name parameter!");
}];

PANObservation *o2 = [object pan_observeChangesToKeyPath:@"flag" withBlock:^(PANKeyValueObservation *obs) {
    NSLog(@"observed change to object's flag parameter!");
}];

PANObservation *o3 = [self pan_observeForNotifications:object named:@"Banana" withBlock:^(id obj, PANNotificationObservation *obs) {
    NSLog(@"observed object posting Banana notification");
}];

PANObservation *o4 = [object pan_observeNotificationsNamed:@"Seaweed" withBlock:^(PANNotificationObservation *obs) {
    NSLog(@"observed object posting Seaweed notification");
}];

...

[self pan_stopObservingForChanges:object toKeyPath:@"name"];
[o4 remove];
```

When you've provided an observer object, that object is passed back as the first parameter to your block. You can use this to avoid having to make your own weak self pointer. You specialize the type of that parameter in your block definition to the expected type and avoid unnecessary casting.

```objective-c
[self pan_observeForChanges:object toKeyPath:@"name" withBlock:^(ViewController *obj, PANKeyValueObservation *obs) {
    [obj handleNameChange];
}];
```

The second parameter the block is an observation object, the same as the `observe` method's result. Not ony can you call `remove` on this object, but it has accessors for all observation details, such as the notification object or the change dictionary:

```objective-c
[self pan_observeForChanges:object toKeyPath:@"name" withBlock:^(id obj, PANKeyValueObservation *obs) {
    NSLog(@"%@ %@ %d %@ %@", obs.changeDict, obs.keyPath, (int)obs.kind, obs.oldValue, obs.changedValue);
}];

[self pan_observeForNotifications:object named:@"Cheesecake" withBlock:^(id obj, PANNotificationObservation *obs) {
    NSLog(@"%@ %@ %@", obs.notification, obs.postedObject, obs.userInfo);
}];
```

There are additional methods which:
- accept KVO option parameters
- observe multiple KVO keypaths at once
- observe a `NSNotification` posted by any object
- observe an object's own KVO changes or notifications
- call the observation block on a specific NSOperationQueue or GCD queue

There's a mechanism for pausing an observation such that when unpaused, the data and a timestamp from every missed call is available.

### Also

Panopticon can be easily extended to other flavor of observations. For example, I've added these capabilities:

#### UIControl Events

```objective-c
[self pan_observeControlForPress:self.button withBlock:^(id obj, PANUIControlObservation *obs) {
}];

[self.field pan_observeEvents:UIControlEventEditingDidBegin withBlock:^(PANUIControlObservation *obs) {
}];
```

#### Cross-App Group Darwin Notifications

```objective-c
[PANAppGroupObservation registerAppGroup:groupId];

[self pan_observeAppGroupNotificationsNamed:@"name" withBlock:^(id obj, PANAppGroupObservation *obs) {
  // called with latest post
  NSLog(@"%@", obs.payload);
}];

[self pan_observeReliablyAppGroupNotificationsNamed:@"updates" withBlock:^(id obj, NSArray *observations) {
  // called with all posts made between last observation
  // even if app was inactive or quit in the meantime
}];

[self.data pan_postWithinAppGroupNotificationNamed:@"x"];
```

## Installation

Panopticon is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Panopticon"
```

Alternately, you can enable shorthand methods that leave the `pan_` prefix off the catgory method names (inspired by MagicalRecord) by instead adding to your Podfile:

```ruby
pod "Panopticon/Shorthand"
```

and also, somewhere in your app's launching process, such as a `+load` method or your app delegate's `application:didFinishLaunching...` method, add this class method call:

```objective-c
[PANObservation setupShorthandMethods];
```

Read the comments in "PanopticonShorthand.h" for more details.

#### Running Example

If using `pod try` or manually cloning the source to try out the Example app, to build the CocoaPods target you must first `cd` into the Example directory and execute `pod install`, then as directed open `Panopticon.xcworkspace` and not the `.xcodeproj` file. Note that the example project also has a second target that builds using static frameworks.


## Author

Pierre Houston, jpmhouston@gmail.com

## License

Panopticon is available under the MIT license. See the LICENSE file for more info.
