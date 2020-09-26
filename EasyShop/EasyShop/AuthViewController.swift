//
//  AuthViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/13/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    //card 1
       @IBOutlet weak var myCard1: UIImageView!
       
       
       //card 2
       @IBOutlet weak var myCard2: UIImageView!
       
       //image
       @IBOutlet weak var mybtnemail: UIImageView!
       
       //btn
       @IBOutlet weak var mybtnnumber: UIImageView!
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
       //animation code
           UIView.animate(withDuration: 1, animations: {
                 self.myCard1.frame.origin.y += 40
               self.myCard2.frame.origin.y += 40
    
               self.mybtnemail.frame.origin.x += 60
               self.mybtnnumber.frame.origin.x -= 60
               
               
               
               
             }, completion: nil)    }
       
    
    

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


