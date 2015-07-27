//
//  UINavigationBar+Animation.swift
//  BusyNavigationBar
//
//  Created by Gunay Mert Karadogan on 22/7/15.
//  Copyright (c) 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

private var BusyNavigationBarLoadingViewAssociationKey: UInt8 = 0
private var BusyNavigationBarOptionsAssociationKey: UInt8 = 1
private var alphaAnimationDurationOfLoadingView = 0.3

extension UINavigationBar {
    private var busy_loadingView: UIView? {
        get {
            return objc_getAssociatedObject(self, &BusyNavigationBarLoadingViewAssociationKey) as? UIView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BusyNavigationBarLoadingViewAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        }
    }

    private var busy_options: BusyNavigationBarOptions {
        get {
            return objc_getAssociatedObject(self, &BusyNavigationBarOptionsAssociationKey) as! BusyNavigationBarOptions
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BusyNavigationBarOptionsAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        }
    }

    public override var bounds: CGRect {
        didSet {
            if oldValue != bounds {

                // If busy_loadingView is in the view hierarchy
                if let superView = busy_loadingView?.superview {

                    // Remove loadingView
                    busy_loadingView?.removeFromSuperview()
                    self.busy_loadingView = nil

                    // Restart
                    start(self.busy_options)
                }
            }
        }
    }

    func start(_ options: BusyNavigationBarOptions? = nil) {
        if let loadingView = self.busy_loadingView {
            loadingView.removeFromSuperview()
        }

        self.busy_options = options ?? BusyNavigationBarOptions()

        insertLoadingView()

        UIView.animateWithDuration(alphaAnimationDurationOfLoadingView, animations: { () -> Void in
            self.busy_loadingView!.alpha = self.busy_options.alpha
        })

        var animationLayer = pickAnimationLayer()
        animationLayer.position = busy_loadingView!.center
        animationLayer.mask = maskLayer()

        busy_loadingView!.layer.addSublayer(animationLayer)
    }

    func stop(){
        if let loadingView = self.busy_loadingView {
            UIView.animateWithDuration(alphaAnimationDurationOfLoadingView, animations: { () -> Void in
                loadingView.alpha = 0.0
            }) { (Completed) -> Void in
                loadingView.removeFromSuperview()
            }
        }
    }

    private func insertLoadingView() {
        busy_loadingView = UIView(frame: bounds)
        busy_loadingView!.center.x = bounds.size.width / 2
        busy_loadingView!.alpha = 0.0
        busy_loadingView!.layer.masksToBounds = true

        //        printSubviews()
        insertSubview(busy_loadingView!, atIndex: 1)
        //        printSubviews()
    }

    private func pickAnimationLayer() -> CALayer {
        var animationLayer: CALayer

        switch busy_options.animationType {
        case .Stripes:
            animationLayer = AnimationLayerCreator.stripeAnimationLayer(bounds)
        case .Bars:
            animationLayer = AnimationLayerCreator.barAnimation(bounds)
        case .Waves:
            animationLayer = AnimationLayerCreator.waveAnimation(bounds)
        case .CustomLayer(let yourLayer):
            animationLayer = yourLayer
        }

        return animationLayer
    }

    private func maskLayer() -> CALayer {
        var alphaLayer = CAGradientLayer()
        alphaLayer.frame = bounds
        alphaLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor]
        return alphaLayer
    }
}

private func printSubviews(subviews: [AnyObject]) {
    print("\n [Printing subviews starts] ")
    for view in subviews {
        print("\n\n")
        print(view)
    }
    print("\n")
    print("\n [Printing subviews ended] \n\n")
}
