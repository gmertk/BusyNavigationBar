//
//  AnimationLayerCreator.swift
//  BusyNavigationBar
//
//  Created by Gunay Mert Karadogan on 27/7/15.
//
//

import UIKit

/**
    A struct holding the functions to create animation layers
*/
struct AnimationLayerCreator {

    /**
        Creates a layer with stripes animating as in Periscope app.

        :param: bounds     The bounds of navigation bar

        :returns: A new layer with stripes animating
    */
    static func stripeAnimationLayer(bounds: CGRect) -> CALayer {
        let r = CAReplicatorLayer()
        r.backgroundColor = UIColor.clearColor().CGColor
        r.bounds = bounds
        r.instanceCount = 40
        r.masksToBounds = true
        r.instanceTransform = CATransform3DMakeTranslation(45, 0, 0)

        let stripe = CALayer()
        let barWidth: CGFloat = 15
        stripe.bounds = CGRect(x: 0, y: 0, width: barWidth, height: bounds.height * 2)
        stripe.backgroundColor = UIColor.grayColor().CGColor
        stripe.position = CGPoint(x: barWidth/2, y: bounds.height / 2)
        stripe.transform = CATransform3DMakeRotation(CGFloat(M_PI / 4), 0, 0, 1)

        r.addSublayer(stripe)

        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = stripe.position.x - 45
        animation.duration = 0.5
        animation.repeatCount = Float.infinity

        stripe.addAnimation(animation, forKey: nil)

        return r
    }


    /**
        Creates a layer with bars animating as in a equalizer

        :param: bounds     The bounds of navigation bar

        :returns: A new layer with bars animating
    */
    static func barAnimation(bounds: CGRect) -> CALayer {
        let r = CAReplicatorLayer()
        r.backgroundColor = UIColor.clearColor().CGColor
        r.bounds = bounds
        r.instanceCount = 40
        r.instanceDelay = 0.1
        r.masksToBounds = true
        r.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)

        let bar = CALayer()
        bar.bounds = CGRect(x: 0, y: 0, width: 10, height: 40)
        bar.backgroundColor = UIColor.redColor().CGColor
        bar.cornerRadius = 2.0
        bar.position = CGPoint(x: 10.0, y: 75.0)
        r.addSublayer(bar)


        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = bar.position.y - 35.0
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity

        bar.addAnimation(animation, forKey: nil)
        
        return r
    }

    static func waveAnimation(bounds: CGRect) -> CALayer {
        return CALayer()
    }
}