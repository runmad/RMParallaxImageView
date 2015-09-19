//
//  ViewController.swift
//  RMParallaxImageViewer
//
//  Created by Rune Madsen on 2015-09-19.
//  Copyright © 2015 The App Boutique. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageLayer1: UIImage = UIImage.init(named: "Interstellar_Layer1")!
        let imageLayer2: UIImage = UIImage.init(named: "Interstellar_Layer2")!
        let imageLayer3: UIImage = UIImage.init(named: "Interstellar_Layer3")!
        let imageLayer4: UIImage = UIImage.init(named: "Interstellar_Layer4")!
        let imageLayer5: UIImage = UIImage.init(named: "Interstellar_Layer5")!
        
        let parrallaxImageView = RMParrallaxImageView(images: [imageLayer1, imageLayer2, imageLayer3, imageLayer4, imageLayer5])
        parrallaxImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(parrallaxImageView)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[parrallaxImageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["parrallaxImageView" : parrallaxImageView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[parrallaxImageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["parrallaxImageView" : parrallaxImageView]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

