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
        
        let imageLayer1 = UIImage(named: "Interstellar_Layer1")!
        let imageLayer2 = UIImage(named: "Interstellar_Layer2")!
        let imageLayer3 = UIImage(named: "Interstellar_Layer3")!
        let imageLayer4 = UIImage(named: "Interstellar_Layer4")!
        let imageLayer5 = UIImage(named: "Interstellar_Layer5")!
        let parrallaxImageView = RMParrallaxImageView(images: [imageLayer1, imageLayer2, imageLayer3, imageLayer4, imageLayer5])
        
//        let imageLayer1: UIImage = UIImage(named: "Avengers_Layer1")!
//        let imageLayer2: UIImage = UIImage(named: "Avengers_Layer2")!
//        let imageLayer3: UIImage = UIImage(named: "Avengers_Layer3")!
//        let parrallaxImageView = RMParrallaxImageView(images: [imageLayer1, imageLayer2, imageLayer3])
        
//        let imageLayer1: UIImage = UIImage(named: "Skyfall_1")!
//        let imageLayer2: UIImage = UIImage(named: "Skyfall_2")!
//        let imageLayer3: UIImage = UIImage(named: "Skyfall_3")!
//        let imageLayer4: UIImage = UIImage(named: "Skyfall_4")!
//        let imageLayer5: UIImage = UIImage(named: "Skyfall_5")!
//        let parrallaxImageView = RMParrallaxImageView(images: [imageLayer1, imageLayer2, imageLayer3, imageLayer4, imageLayer5])
        
        self.view.addSubview(parrallaxImageView)
        parrallaxImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [parrallaxImageView.topAnchor.constraint(equalTo: view.topAnchor),
                           parrallaxImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           parrallaxImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           parrallaxImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}

