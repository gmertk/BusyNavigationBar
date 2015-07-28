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

    - Stripes: Sliding stripes as seen in Periscope app.
    - Bars: Bars going up and down like a wave.
    - CustomLayer: Your layer to be inserted above navigation bar's background.
*/
enum BusyAnimationType {
    case Stripes, Bars, CustomLayer(CALayer)
}

/**
    Options to customize the behaviour of BusyNavigationBar
*/
class BusyNavigationBarOptions {
    /// Color of the shapes
    var color = UIColor.grayColor()

    /// Alpha of the animation layer. Remember that there is also an additional (constant) gradient mask over the animation layer.
    var alpha: CGFloat = 0.5

    /// Animation type
    var animationType: BusyAnimationType = .Stripes

    /// Width of the bar
    var barWidth: CGFloat = 20

    /// Gap between bars
    var gapWidth: CGFloat = 30

    /// Speed of the animation
    var speed: Float = 1

    /// Flag for enabling the transparent masking layer over the animation layer.
    var transparentMaskEnabled = true

    init() {}
    
    init(color: UIColor, alpha: CGFloat, animationType: BusyAnimationType, barWidth: CGFloat, gapWidth: CGFloat, speed: Float, transparentMaskEnabled: Bool) {
        self.color = color
        self.alpha = alpha
        self.animationType = animationType
        self.barWidth = barWidth
        self.gapWidth = gapWidth
        self.speed = speed
        self.transparentMaskEnabled = transparentMaskEnabled
    }
}