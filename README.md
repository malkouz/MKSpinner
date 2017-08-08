## MKSpinner

[![Version](https://img.shields.io/cocoapods/v/MKSpinner.svg?style=flat)](http://cocoapods.org/pods/MKSpinner)
[![License](https://img.shields.io/cocoapods/l/MKSpinner.svg?style=flat)](http://cocoapods.org/pods/MKSpinner)
[![Platform](https://img.shields.io/cocoapods/p/MKSpinner.svg?style=flat)](http://cocoapods.org/pods/MKSpinner)


## Beautiful activity indicator.
Beautiful activity indicator. Same of MKSpinner with changed animation (https://github.com/icanzilb/MKSpinner)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 8 or later 

## Installation

MKSpinner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKSpinner"
```

#### Code samples

The simple code to get `MKSpinner` running in your own app.

* In case you installed MKSpinner via CocoaPods you need to import it (add this somewhere at the top of your source code file):

```swift
import MKSpinner
```

* When you want to show an animated activity (eg. rings are randomly rotating around):

```swift
MKSpinner.show("Connecting to satellite...")
```

* If you want to show a static activity indicator (eg. a message with two complete rings around it)

```swift
MKSpinner.show("Failed to connect, waiting...", animated: false)
```

* When you want to hide the activity:

```swift
MKSpinner.hide()
```

In case you want to do something after the hiding animation completes you can provide a closure to the `hide()` method:

```swift
MKSpinner.hide({
//do stuff
})
```


That's all. If you want to change the text of the current activity, just call `show(...)` again, this will animate the old text into the new text.


## Author

Moayad Al kouz, moayad_kouz9@hotmail.com

## License

MKSpinner is available under the MIT license. See the LICENSE file for more info.
