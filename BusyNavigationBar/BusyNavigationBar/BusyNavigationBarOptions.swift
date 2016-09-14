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
 - CustomLayer(() -> CALayer): Your layer to be inserted above navigation bar's background. In this case, properties other than transparentMaskEnabled and alpha will not be used.
 */
public enum BusyAnimationType {
    case stripes, bars, customLayer(() -> CALayer)
}

/**
 Options to customize the behaviour of BusyNavigationBar
 */
open class BusyNavigationBarOptions {
    /// Animation type. Defaults to .Stripes.
    open var animationType: BusyAnimationType = .stripes
    
    /// Color of the shapes. Defaults to gray.
    open var color = UIColor.gray
    
    /// Alpha of the animation layer. Remember that there is also an additional (constant) gradient mask over the animation layer. Defaults to 0.5.
    open var alpha: CGFloat = 0.5
    
    /// Width of the bar. Defaults to 20.
    open var barWidth: CGFloat = 20
    
    /// Gap between bars. Defaults to 30.
    open var gapWidth: CGFloat = 30
    
    /// Speed of the animation. 1 corresponds to 0.5 sec. Defaults to 1.
    open var speed: Float = 1
    
    /// Flag for enabling the transparent masking layer over the animation layer.
    open var transparentMaskEnabled = true
    
    public init() {}
    
    public init(color: UIColor, alpha: CGFloat, animationType: BusyAnimationType, barWidth: CGFloat, gapWidth: CGFloat, speed: Float, transparentMaskEnabled: Bool) {
        self.color = color
        self.alpha = alpha
        self.animationType = animationType
        self.barWidth = barWidth
        self.gapWidth = gapWidth
        self.speed = speed
        self.transparentMaskEnabled = transparentMaskEnabled
    }
}
