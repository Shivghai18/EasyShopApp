//
//  LoginViewController.swift
//  EasyShop
//
//  Created by user163874 on 8/13/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {
  
    @IBOutlet weak var txtpassword: UITextField!
     
     @IBOutlet weak var txtUserName: UITextField!
    
    static var userNameId  : String?                    //creating a static variable which will store the username of the user logged in and will use it as a session variable in                                                   //different pages
    var flag: Int = 0
    var shouldLogin=""
    
    @IBAction func logIn(_ sender: UIButton) {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext      //getting the context from the app delegate and having persistent history
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")                 //NSFetchrequest object to get the records from the login table to check all the u                                                                                                //usernames and passwords
        
        request.returnsObjectsAsFaults = false
        
        if txtpassword.text! == "" || txtUserName.text! == ""                               //checking if the textfields are empty and showing messages
        {
                let alert = UIAlertController(title: "Login", message: "Please enter values", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        else{
            do{
                let result = try context.fetch(request)                                    //getting result into result object
               
                for data in result as! [NSManagedObject]                                    //foreach loop for travering the entire object
                {
                    let userNameData = data.value(forKey: "username") as? String
                    let passwordData = data.value(forKey: "password") as? String
                    LoginViewController.self.userNameId = txtUserName.text
                    if txtUserName.text ==  userNameData && txtpassword.text == passwordData
                    {                                                                       //comparing the credentials with the values entered in textfields
                       
                            shouldLogin="yes"
                            flag=0
                            print("Here in password: -----------------------------\(shouldLogin)")
                            shouldPerformSegue(withIdentifier: "seg1", sender: self)  //created this varaible for should performsegue, if the credials are wrong will make
                                                                                    //the variable as
                        return 
                    }
                    else{
                            
                            flag=1          //calling should perform segue
                            
                           
                    }
                    
                }
                if flag==1
                {
                    shouldLogin="no"
                     print("Here in failed: --------------------\(shouldLogin)")
                    shouldPerformSegue(withIdentifier: "seg1", sender: self)
                }
                
                
            }
            catch{ let alert = UIAlertController(title: "Login", message: "Login Un-Successful", preferredStyle: UIAlertController.Style.alert)
                                       alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                                       self.present(alert, animated: true, completion: nil)
                shouldLogin="no"
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let vc  = segue.destination as! HomeViewController
        
               }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(shouldLogin=="yes")                                          //if the shouldlogin varaible is yes, then we perform segue otherwise not.
        {
            return true;
        }
        else{
            let alert = UIAlertController(title: "Login", message: "Login Un-Successful", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        return false
    }
  
    @IBOutlet weak var imageLogo: UIImageView!
    
   
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {             //this part of coding is to hide the entire keypad if i click anywhere in the mobile                                                                                         //screen
                  view.endEditing(true)
                  super.touchesBegan(touches, with: event)
              }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
