//
//  RMParallaxImageView.swift
//  RMParallaxImageViewer
//
//  Created by Rune Madsen on 2015-09-19.
//  Copyright © 2015 The App Boutique. All rights reserved.
//

import UIKit

class RMParrallaxImageView: UIView {
    
    fileprivate var effectIsActive = false
    fileprivate var imageArray = [UIImage]()
    fileprivate var motionEffectGroups = [UIMotionEffectGroup]()
    fileprivate var effectOffImageConstraints = [NSLayoutConstraint]()
    fileprivate var effectOnImageConstraints = [NSLayoutConstraint]()
    fileprivate let containerView = UIView()
    
    init(lsr: AnyObject) {
        super.init(frame: CGRect.zero)
        setupImages()
    }
    
    init(images imageArray: [UIImage]) {
        super.init(frame: CGRect.zero)
        self.imageArray = imageArray
        self.backgroundColor = .white
        setupImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupImages() {
        self.clipsToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        self.addSubview(containerView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RMParrallaxImageView.toggleEffect(_:)))
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        let constraints = [containerView.topAnchor.constraint(equalTo: topAnchor),
                           containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                           containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                           containerView.trailingAnchor.constraint(equalTo: trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
        
        var effectOffArray = [NSLayoutConstraint]()
        var effectOnArray = [NSLayoutConstraint]()
        
        for (index, image) in self.imageArray.enumerated() {
            let imageView: UIImageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            self.containerView.addSubview(imageView)
            
            self.containerView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0))
            self.containerView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0))
            
            let heightLayoutConstraint = NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1.0, constant: 0)
            let widthLayoutConstraint = NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0)
            effectOffArray.append(contentsOf: [heightLayoutConstraint, widthLayoutConstraint])
            
            let constant: CGFloat = CGFloat(index) * 10;
            print(constant)
            let heightLayoutConstraintWithEffect = NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1.0, constant: constant)
            let widthLayoutConstraintWithEffect = NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: constant)
            effectOnArray.append(contentsOf: [heightLayoutConstraintWithEffect, widthLayoutConstraintWithEffect])
            
            // Prepare motion effects
            
            let effect: CGFloat = constant * 2;
            
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                type: .tiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -effect
            verticalMotionEffect.maximumRelativeValue = effect
            
            // Set horizontal effect
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                type: .tiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -effect
            horizontalMotionEffect.maximumRelativeValue = effect
            
            let motionEffectGroup = UIMotionEffectGroup()
            motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
            
            self.motionEffectGroups.append(motionEffectGroup)
        }
        
        effectOffImageConstraints = effectOffArray
        effectOnImageConstraints = effectOnArray
        
        NSLayoutConstraint.activate(effectOffImageConstraints)
    }
    
    @objc func toggleEffect(_ recognizer: UITapGestureRecognizer) {
        if self.effectIsActive {
            NSLayoutConstraint.deactivate(effectOnImageConstraints)
            NSLayoutConstraint.activate(effectOffImageConstraints)
        } else {
            NSLayoutConstraint.deactivate(effectOffImageConstraints)
            NSLayoutConstraint.activate(effectOnImageConstraints)
        }
        self.effectIsActive = !self.effectIsActive
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let `self` = self else { return }
                self.layoutIfNeeded()
                for (index, imageView) in self.containerView.subviews.enumerated() {
                    let motionEffect = self.motionEffectGroups[index]
                    if self.effectIsActive {
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
