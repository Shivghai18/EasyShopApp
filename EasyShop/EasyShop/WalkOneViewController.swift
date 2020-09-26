//
//  WalkOneViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/13/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class WalkOneViewController: UIViewController {

   //my image
       
    @IBOutlet weak var myImage: UIImageView!
    
       //
       let newButtonWidth: CGFloat = 100

       override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
               let oldValue = myImage.frame.width/2

   /* Do Animations */
   CATransaction.begin() //1
   CATransaction.setAnimationDuration(2.0) //2
   CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)) //3

   // View animations //4
           UIView.animate(withDuration: 0.5) {            
       self.myImage.frame = CGRect(x: 0, y: 0, width: self.newButtonWidth, height: self.newButtonWidth)
       self.myImage.center = self.view.center
   }

   // Layer animations
   let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius)) //5
   cornerAnimation.fromValue = oldValue //6
   cornerAnimation.toValue = newButtonWidth/2 //7

   myImage.layer.cornerRadius = newButtonWidth/2 //8
   myImage.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius)) //9

   CATransaction.commit() //10
           
           
           
           
           
       }
}
