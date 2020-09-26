//
//  SplashViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/13/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    
     override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           
           
               //animation for logo
           UIView.animate(withDuration: 2.0) { //1
               self.myImageview.frame = CGRect(x: 0, y: 0, width: self.newButtonWidth, height: self.newButtonWidth) //2
               self.myImageview.center = self.view.center //3
           }
           
    }

          //my label
       
    @IBOutlet weak var mylabel: UILabel!
    //my image
    
    @IBOutlet weak var myImageview: UIImageView!
    //imagesize float
       let newButtonWidth: CGFloat = 100
             //label size float
           let newButtonWidth1: CGFloat = 400
    
}
