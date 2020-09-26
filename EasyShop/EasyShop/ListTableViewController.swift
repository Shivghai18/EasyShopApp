//
//  ListTableViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/4/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController  {
  
   
        //Creating array from db class product
        var ProductArray = [Item]()
    var billItemArray = [BillItem]()
    
    var totalamount : Double = 0
    
    
      var selectedCategory : Category? {
          didSet{
              loadItems()
          }
      }
        
        //creating context to load our conatainer db from delegates as object
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
       override func viewDidLoad() {
           super.viewDidLoad()
       }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {           //delete from core data
        if editingStyle == .delete{
            
            context.delete(ProductArray[indexPath.row])
            ProductArray.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    
    }

   
    @IBAction func myDonebtn(_ sender: UIBarButtonItem) {           //shoing the total amount
        
        let alert = UIAlertController(title: "Total", message: "\(totalamount)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
   }
    
    
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return ProductArray.count
           }
    
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //entering item price when clicking on the item and also sending the particular item at the end of the list and checking it and unchecking it and changing the status as //well.
        let alert = UIAlertController(title: "Add Product Price", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.textFields![0].placeholder = "Enter Price"
        alert.textFields![0].keyboardType = UIKeyboardType.decimalPad
        
    
        alert.addAction(UIAlertAction(title: "Enter Price", style: .default , handler:{(action) in
            self.totalamount += (Double(alert.textFields![0].text!)! * Double(self.ProductArray[indexPath.row].quantity!)!)
        }))
        
        self.present(alert, animated: true)
        
                        
       ProductArray[indexPath.row].status = !ProductArray[indexPath.row].status
        saveItems()
        var temp : Item?
        
        temp = ProductArray.remove(at: indexPath.row)
        
        ProductArray.append(temp!)
        
            
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
            
        }
    
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
               
                    cell.textLabel?.text = ProductArray[indexPath.row].name
                        cell.detailTextLabel!.text = ProductArray[indexPath.row].quantity
            
            cell.accessoryType = ProductArray[indexPath.row].status ? .checkmark : .none

               return cell
           }
        
         
    @IBAction func mybutton(_ sender: UIBarButtonItem) {        //adding a product name and quantity
    
    
     let alert = UIAlertController(title: "Add New Product", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addTextField()
        
        
        alert.textFields![0].placeholder = "Enter Item"
        alert.textFields![0].keyboardType = UIKeyboardType.alphabet
        
        alert.textFields![1].placeholder = "Enter Qantity"
        alert.textFields![1].keyboardType = UIKeyboardType.alphabet
        
        
        alert.addAction(UIAlertAction(title: "Add Product", style: .default , handler:{(action) in
            
             let newProduct = Item(context: self.context)
            newProduct.name = alert.textFields![0].text
            newProduct.quantity = alert.textFields![1].text
            newProduct.parentCategory = self.selectedCategory
            self.ProductArray.append(newProduct)
            
            self.saveItems()

        }))
        
        self.present(alert, animated: true)
        
    }
        
        func saveItems() {
            
            do {
              try context.save()
            } catch {
               print("Error saving context \(error)")
            }
            
            self.tableView.reloadData()
        }
    
       func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {        //show all the items of a particular category
           
           let categoryPredicate = NSPredicate(format: "parentCategory.categoryname MATCHES %@", selectedCategory!.categoryname!)
           
           if let addtionalPredicate = predicate {
               request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
           } else {
               request.predicate = categoryPredicate
           }

           
           do {
               ProductArray = try context.fetch(request)
           } catch {
               print("Error fetching data from context \(error)")
           }
           
           tableView.reloadData()
           
       }
    
    

}


extension ListTableViewController: UISearchBarDelegate {
                    //adding functionality for search in the code
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request : NSFetchRequest<Item> = Item.fetchRequest()
    
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          
        }
    }
}



