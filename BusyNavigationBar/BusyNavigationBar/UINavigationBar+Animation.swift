//
//  UINavigationBar+Animation.swift
//  BusyNavigationBar
//
//  Created by Gunay Mert Karadogan on 22/7/15.
//  Copyright (c) 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

private var BusyNavigationBarLoadingLayerAssociationKey: UInt8 = 0
private var BusyNavigationBarOptionsAssociationKey: UInt8 = 1
private var alphaAnimationDurationOfLoadingView = 0.3

extension UINavigationBar {
    private var busy_loadingLayer: CALayer? {
        get {
            return objc_getAssociatedObject(self, &BusyNavigationBarLoadingLayerAssociationKey) as? CALayer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BusyNavigationBarLoadingLayerAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var busy_options: BusyNavigationBarOptions {
        get {
            return objc_getAssociatedObject(self, &BusyNavigationBarOptionsAssociationKey) as! BusyNavigationBarOptions
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BusyNavigationBarOptionsAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public override var bounds: CGRect {
        didSet {
            if oldValue != bounds {
                if let loadingLayer = self.busy_loadingLayer {
                    loadingLayer.removeFromSuperlayer()
                    
                    self.busy_loadingLayer = nil
                    
                    start(self.busy_options)
                }
            }
        }
    }
    
    public func start(options: BusyNavigationBarOptions? = nil) {
        if let loadingLayer = self.busy_loadingLayer {
            loadingLayer.removeFromSuperlayer()
        }
        
        busy_options = options ?? BusyNavigationBarOptions()
        
        busy_loadingLayer = pickAnimationLayer()
        busy_loadingLayer?.masksToBounds = true
        busy_loadingLayer?.position.x = bounds.size.width / 2
        busy_loadingLayer?.position.y = bounds.size.height / 2
        
        if busy_options.transparentMaskEnabled {
            busy_loadingLayer?.mask = maskLayer()
        }
        
        UIView.animateWithDuration(alphaAnimationDurationOfLoadingView, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            // Looks like in CALayers instead of alpha it's called opacity
            self.busy_loadingLayer?.opacity = Float(self.busy_options.alpha)
            }) { (finished) -> Void in
                // Finished..
        }
        
        // Add the busy_loadingLayer directly as sublayer
        self.layer.addSublayer(busy_loadingLayer!)
    }
    
    public func stop(){
        if let _ = self.busy_loadingLayer {
            UIView.animateWithDuration(alphaAnimationDurationOfLoadingView, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.busy_loadingLayer?.opacity = 0.0
                }) { (finished) -> Void in
                    // Finished..
            }
        }
    }
    
    func pickAnimationLayer() -> CALayer {
        var animationLayer: CALayer
        
        switch busy_options.animationType {
        case .Stripes:
            animationLayer = AnimationLayerCreator.stripeAnimationLayer(bounds, options: busy_options)
        case .Bars:
            animationLayer = AnimationLayerCreator.barAnimation(bounds, options: busy_options)
        case .CustomLayer(let layerCreator):
            animationLayer = layerCreator()
        }
        
        return animationLayer
    }
    
    func maskLayer() -> CALayer {
        let alphaLayer = CAGradientLayer()
        alphaLayer.frame = bounds
        alphaLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).CGColor]
        return alphaLayer
    }
}
