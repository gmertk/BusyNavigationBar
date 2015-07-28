//
//  BusyNavigationBarOptions.swift
//  BusyNavigationBar
//
//  Created by Gunay Mert Karadogan on 27/7/15.
//
//

import UIKit

/**
    Animation type

    - Bars: For streets or trails.
    - Stripes: For long journeys.
    - YourAnimation: For casual trips around town.
    - Hybrid: For general-purpose transportation.
*/
enum BusyAnimationType {
    case Stripes, Bars, CustomLayer(CALayer)
}

/**
    Options to customize the behaviour of BusyNavigationBar
*/
class BusyNavigationBarOptions {
    /// Color of the shapes
    var color = UIColor.whiteColor()

    ///
    var alpha: CGFloat = 0.5

    ///
    var animationType: BusyAnimationType = .Stripes

    init() {}
    
    init(color: UIColor, alpha: CGFloat, animationType: BusyAnimationType) {
        self.color = color
        self.alpha = alpha
        self.animationType = animationType
    }
}