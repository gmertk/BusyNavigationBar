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
        Creates a layer with bars animating as in a equalizer. As in Marin Todorov's newsletter.

        :param: bounds     The bounds of navigation bar

        :returns: A new layer with bars animating
    */
    static func barAnimation(bounds: CGRect) -> CALayer {
        let barWidth: CGFloat = 15
        let barHeight = bounds.height

        let replicator = CAReplicatorLayer()

        replicator.backgroundColor = UIColor.clearColor().CGColor
        replicator.bounds = bounds
        replicator.instanceCount = 40
        replicator.instanceDelay = 0.1

        replicator.masksToBounds = true
        replicator.instanceTransform = CATransform3DMakeTranslation(barWidth * 2, 0, 0)

        let bar = CALayer()
        bar.bounds = CGRect(x: 0, y: 0, width: barWidth, height: barHeight)
        bar.backgroundColor = UIColor.grayColor().CGColor
        bar.cornerRadius = 1.0
        bar.position = CGPoint(x: barWidth/2, y: bounds.height)
        replicator.addSublayer(bar)

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = bounds.height / 2
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity

        bar.addAnimation(animation, forKey: nil)

        return replicator
    }

    static func waveAnimation(bounds: CGRect) -> CALayer {
        var pathLow: UIBezierPath {
            let path = UIBezierPath()
            path.moveToPoint(CGPointMake(0, 20))
            path.addCurveToPoint(CGPointMake(176.63, 25.55), controlPoint1: CGPointMake(3.37, 20.55), controlPoint2: CGPointMake(50.5, 37.55))
            path.addCurveToPoint(CGPointMake(375, 19.55), controlPoint1: CGPointMake(302.76, 13.55), controlPoint2: CGPointMake(377.5, 19.55))
            path.addLineToPoint(CGPoint(x: 375, y: 44))
            path.addLineToPoint(CGPoint(x: 0, y: 44))

            path.closePath()
            return path
        }

        var pathHigh: UIBezierPath {
            var path = UIBezierPath()
            path.moveToPoint(CGPointMake(0, 15))
            path.addCurveToPoint(CGPointMake(173.63, 15), controlPoint1: CGPointMake(3.37, 15.5), controlPoint2: CGPointMake(43.54, -0.5))
            path.addCurveToPoint(CGPointMake(375, 10), controlPoint1: CGPointMake(303.72, 29.5), controlPoint2: CGPointMake(374.5, 8.5))
            path.addLineToPoint(CGPoint(x: 375, y: 44))
            path.addLineToPoint(CGPoint(x: 0, y: 44))
            path.closePath()
            return path
        }

        let layer = CAShapeLayer()
        layer.fillColor = UIColor.blueColor().CGColor
        layer.bounds = bounds

        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = pathLow.CGPath
        animation.toValue = pathHigh.CGPath
        animation.beginTime = 0.0
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity

        layer.addAnimation(animation, forKey: nil)
        return layer
    }
}