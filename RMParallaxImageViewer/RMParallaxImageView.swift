//
//  RMParallaxImageView.swift
//  RMParallaxImageViewer
//
//  Created by Rune Madsen on 2015-09-19.
//  Copyright © 2015 The App Boutique. All rights reserved.
//

import UIKit

class RMParrallaxImageView: UIView {
    
    private var effectIsActive = false
    private var imageArray: [UIImage] = []
    private var motionEffectGroups: NSMutableArray = NSMutableArray()
    private var effectOffImageConstraints: NSArray = []
    private var effectOnImageConstraints: NSArray = []
    private let containerView = UIView.init()
    
    init(lsr: AnyObject) {
        super.init(frame: CGRectZero)
        setupImages()
    }
    
    init(images imageArray: [UIImage]) {
        super.init(frame: CGRectZero)
        self.imageArray = imageArray
        setupImages()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupImages() {
        self.clipsToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        self.addSubview(containerView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("toggleEffect:"))
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        let views = ["containerView" : self.containerView]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        let effectOffArray = NSMutableArray()
        let effectOnArray = NSMutableArray()
        
        for var i = 0; i < self.imageArray.count; i++ {
            let imageView: UIImageView = UIImageView.init(image: self.imageArray[i])
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .ScaleAspectFill
            self.containerView.addSubview(imageView)
            
            self.containerView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1.0, constant: 0))
            self.containerView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1.0, constant: 0))
            
            let heightLayoutConstraint = NSLayoutConstraint.init(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: 0)
            let widthLayoutConstraint = NSLayoutConstraint.init(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: containerView, attribute: .Width, multiplier: 1.0, constant: 0)
            effectOffArray.addObjectsFromArray([heightLayoutConstraint, widthLayoutConstraint]);
            
            let constant: CGFloat = CGFloat(i) * 10;
            print(constant)
            let heightLayoutConstraintWithEffect = NSLayoutConstraint.init(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: containerView, attribute: .Height, multiplier: 1.0, constant: constant)
            let widthLayoutConstraintWithEffect = NSLayoutConstraint.init(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: containerView, attribute: .Width, multiplier: 1.0, constant: constant)
            effectOnArray.addObjectsFromArray([heightLayoutConstraintWithEffect, widthLayoutConstraintWithEffect]);
            
            // Prepare motion effects
            
            let effect: CGFloat = constant * 2;
            
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                type: .TiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -effect
            verticalMotionEffect.maximumRelativeValue = effect
            
            // Set horizontal effect
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                type: .TiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -effect
            horizontalMotionEffect.maximumRelativeValue = effect
            
            let motionEffectGroup = UIMotionEffectGroup()
            motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
            
            self.motionEffectGroups.addObject(motionEffectGroup)
            
//            // Add both effects to your view
//            imageView.addMotionEffect(motionEffectGroup)
        }
        
        effectOffImageConstraints = effectOffArray as NSArray
        effectOnImageConstraints = effectOnArray as NSArray
        
        NSLayoutConstraint.activateConstraints(effectOffImageConstraints as! [NSLayoutConstraint])
    }
    
    func toggleEffect(recognizer: UITapGestureRecognizer) {
        if (self.effectIsActive) {
            NSLayoutConstraint.deactivateConstraints(self.effectOnImageConstraints as! [NSLayoutConstraint])
            NSLayoutConstraint.activateConstraints(self.effectOffImageConstraints as! [NSLayoutConstraint])
        } else {
            NSLayoutConstraint.deactivateConstraints(self.effectOffImageConstraints as! [NSLayoutConstraint])
            NSLayoutConstraint.activateConstraints(self.effectOnImageConstraints as! [NSLayoutConstraint])
        }
        self.effectIsActive = !self.effectIsActive
        self.setNeedsLayout()
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: .CurveEaseOut,
            animations: {
                self.layoutIfNeeded()
                for var i = 0; i < self.containerView.subviews.count; i++ {
                    let imageView = self.containerView.subviews[i]
                    let motionEffect = self.motionEffectGroups[i] as! UIMotionEffectGroup
                    if (self.effectIsActive) {
                        imageView.addMotionEffect(motionEffect)
                    } else {
                        imageView.removeMotionEffect(motionEffect)
                    }
                }
            },
            completion: { finished in
        })
    }
}
