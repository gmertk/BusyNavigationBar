# BusyNavigationBar
[![Version](https://img.shields.io/cocoapods/v/BusyNavigationBar.svg?style=flat)](http://cocoapods.org/pods/BusyNavigationBar)
[![License](https://img.shields.io/cocoapods/l/BusyNavigationBar.svg?style=flat)](http://cocoapods.org/pods/BusyNavigationBar)
[![Platform](https://img.shields.io/cocoapods/p/BusyNavigationBar.svg?style=flat)](http://cocoapods.org/pods/BusyNavigationBar)

A UINavigationBar extension to show loading effects above navigation bar's background.

## Screenshot

### Stripes
![gray_stripe.gif](https://raw.githubusercontent.com/gmertk/BusyNavigationBar/master/Screenshots/gray_stripe.gif)
![blue_stripe2.gif](https://raw.githubusercontent.com/gmertk/BusyNavigationBar/master/Screenshots/blue_stripe2.gif)

### Bars
![gray_bar.gif](https://raw.githubusercontent.com/gmertk/BusyNavigationBar/master/Screenshots/gray_bar.gif)
![green_bar.gif](https://raw.githubusercontent.com/gmertk/BusyNavigationBar/master/Screenshots/green_bar.gif)

### Your custom layer
![gray_bird.gif](https://raw.githubusercontent.com/gmertk/BusyNavigationBar/master/Screenshots/gray_bird.gif)

## Usage

BusyNavigationBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```ruby
use_frameworks!
pod "BusyNavigationBar"
```

Or add the following lines to your Cartfile:

```bash
github "gmertk/BusyNavigationBar" "master"
```
	
After installation is done, you can use the new methods of your navigation bar; `start(_ options: BusyNavigationBarOptions)` and `stop()`.

## Properties
```swift
var options = BusyNavigationBarOptions()

/**
    Animation type

    - Stripes: Sliding stripes as seen in Periscope app.
    - Bars: Bars going up and down like a wave.
    - CustomLayer(() -> CALayer): Your layer to be inserted in navigation bar. In this case, properties other than `transparentMaskEnabled` and `alpha` will not be used. 
*/
options.animationType = .Stripes

/// Color of the shapes. Defaults to gray.
options.color = UIColor.grayColor()

/// Alpha of the animation layer. Remember that there is also an additional (constant) gradient mask over the animation layer. Defaults to 0.5.
options.alpha = 0.5

/// Width of the bar. Defaults to 20.
options.barWidth = 20

/// Gap between bars. Defaults to 30.
options.gapWidth = 30

/// Speed of the animation. 1 corresponds to 0.5 sec. Defaults to 1.
options.speed = 1

/// Flag for enabling the transparent masking layer over the animation layer.
options.transparentMaskEnabled = true


// Start animation
self.navigationController?.navigationBar.start(options)

// Stop animation
self.navigationController?.navigationBar.stop()
```

## Author

Günay Mert Karadoğan, mertkaradogan@gmail.com

## License

BusyNavigationBar is available under the MIT license. See the LICENSE file for more info.


## More 

There is [a nice tutorial](http://www.thinkandbuild.it/implementing-the-periscope-app-pull-to-refresh/) about Periscope's pull-to-refresh control by @bitwaker.
