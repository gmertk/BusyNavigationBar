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
    fileprivate var busy_loadingView: UIView? {
        get {
            return objc_getAssociatedObject(self, &BusyNavigationBarLoadingViewAssociationKey) as? UIView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BusyNavigationBarLoadingViewAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    fileprivate var busy_options: BusyNavigationBarOptions {
        get {
            return objc_getAssociatedObject(self, &BusyNavigationBarOptionsAssociationKey) as! BusyNavigationBarOptions
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BusyNavigationBarOptionsAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    open override var bounds: CGRect {
        didSet {
            if oldValue != bounds {

                // If busy_loadingView is in the view hierarchy
                if let _ = busy_loadingView?.superview {

                    // Remove loadingView
                    busy_loadingView?.removeFromSuperview()
                    self.busy_loadingView = nil

                    // Restart
                    start(self.busy_options)
                }
            }
        }
    }

    public func start(_ options: BusyNavigationBarOptions? = nil) {
        if let loadingView = self.busy_loadingView {
            loadingView.removeFromSuperview()
        }

        busy_options = options ?? BusyNavigationBarOptions()

        insertLoadingView()

        UIView.animate(withDuration: alphaAnimationDurationOfLoadingView, animations: { () -> Void in
            self.busy_loadingView!.alpha = self.busy_options.alpha
        })

        let animationLayer = pickAnimationLayer()
        animationLayer.masksToBounds = true
        animationLayer.position = busy_loadingView!.center

        if busy_options.transparentMaskEnabled {
            animationLayer.mask = maskLayer()
        }

        busy_loadingView!.layer.addSublayer(animationLayer)
    }

    public func stop(){
        if let loadingView = self.busy_loadingView {
            UIView.animate(withDuration: alphaAnimationDurationOfLoadingView, animations: { () -> Void in
                loadingView.alpha = 0.0
            }, completion: { (Completed) -> Void in
                loadingView.removeFromSuperview()
            }) 
        }
    }

    func insertLoadingView() {
        busy_loadingView = UIView(frame: bounds)
        busy_loadingView!.center.x = bounds.size.width / 2
        busy_loadingView!.alpha = 0.0
        busy_loadingView!.layer.masksToBounds = true
        busy_loadingView!.isUserInteractionEnabled = false
        insertSubview(busy_loadingView!, at: 1)
    }

    func pickAnimationLayer() -> CALayer {
        var animationLayer: CALayer

        switch busy_options.animationType {
        case .stripes:
            animationLayer = AnimationLayerCreator.stripeAnimationLayer(bounds, options: busy_options)
        case .bars:
            animationLayer = AnimationLayerCreator.barAnimation(bounds, options: busy_options)
        case .customLayer(let layerCreator):
            animationLayer = layerCreator()
        }

        return animationLayer
    }

    func maskLayer() -> CALayer {
        let alphaLayer = CAGradientLayer()
        alphaLayer.frame = bounds
        alphaLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor]
        return alphaLayer
    }
}
