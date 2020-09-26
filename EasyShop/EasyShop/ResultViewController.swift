//
//  ResultViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/12/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var amountLbl: UILabel!
     @IBOutlet weak var mytableView: UITableView!
       var billitemArrayResult : [BillItem]?
    
       var Total : Double?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(billitemArrayResult)
        for p in billitemArrayResult! {
            
            let frame = CGRect(x: 132, y: 220, width: 25, height: 21)
            let label = UILabel(frame: frame)
//Total = Total! + ((Double(p.itemQantity!) * Double(p.price!)))
         //   label.text = ("\(p.itemName)+\(self.Total)")
            
            label.text = "hi"
            
            view.addSubview(label)
        
            
        }
        
    }
    
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return billitemArrayResult!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
               
        cell.textLabel?.text = billitemArrayResult![indexPath.row].itemName
        print("Quantity: \(billitemArrayResult![indexPath.row].itemQantity), Price: \(billitemArrayResult![indexPath.row].itemQantity)")
            print("Here")
        cell.detailTextLabel?.text = "Quantity: \(billitemArrayResult![indexPath.row].itemQantity), Price: \(billitemArrayResult![indexPath.row].itemQantity)"
               
               return cell
        
    }
    
}
