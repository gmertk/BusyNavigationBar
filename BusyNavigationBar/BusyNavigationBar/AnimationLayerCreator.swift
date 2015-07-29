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

        :param: bounds  The bounds of navigation bar

        :returns: A new layer with stripes animating
    */
    static func stripeAnimationLayer(bounds: CGRect, options: BusyNavigationBarOptions) -> CALayer {
        let barWidth = options.barWidth

        let replicator = CAReplicatorLayer()
        replicator.backgroundColor = UIColor.clearColor().CGColor
        replicator.bounds = bounds
        replicator.instanceCount = 40
        replicator.instanceTransform = CATransform3DMakeTranslation(options.gapWidth + barWidth, 0, 0)

        let stripe = CALayer()
        stripe.bounds = CGRect(x: 0, y: 0, width: barWidth, height: bounds.height * 2)
        stripe.backgroundColor = options.color.CGColor
        stripe.position = CGPoint(x: barWidth / 2, y: bounds.height / 2)
        stripe.transform = CATransform3DMakeRotation(CGFloat(M_PI / 4), 0, 0, 1)
        replicator.addSublayer(stripe)

        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = stripe.position.x - (options.gapWidth + barWidth)
        animation.duration = 0.5
        animation.speed = options.speed
        animation.repeatCount = Float.infinity
        stripe.addAnimation(animation, forKey: nil)

        return replicator
    }


    /**
        Creates a layer with bars animating as in a equalizer. As in Marin Todorov's newsletter.

        :param: bounds  The bounds of navigation bar

        :returns: A new layer with bars animating
    */
    static func barAnimation(bounds: CGRect, options: BusyNavigationBarOptions) -> CALayer {
        let barWidth: CGFloat = options.barWidth
        let barHeight = bounds.height

        let replicator = CAReplicatorLayer()
        replicator.backgroundColor = UIColor.clearColor().CGColor
        replicator.bounds = bounds
        replicator.instanceCount = 40
        replicator.instanceDelay = 0.1
        replicator.instanceTransform = CATransform3DMakeTranslation(options.gapWidth, 0, 0)

        let bar = CALayer()
        bar.bounds = CGRect(x: 0, y: 0, width: barWidth, height: barHeight)
        bar.backgroundColor = options.color.CGColor
        bar.cornerRadius = 1.0
        bar.position = CGPoint(x: barWidth/2, y: bounds.height)
        replicator.addSublayer(bar)

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = bounds.height / 2
        animation.duration = 0.5
        animation.speed = options.speed
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        bar.addAnimation(animation, forKey: nil)

        return replicator
    }

}