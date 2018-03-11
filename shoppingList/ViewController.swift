//
//  ViewController.swift
//  shoppingList
//
//  Created by steve groves on 09/03/2018.
//  Copyright © 2018 steve groves. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - Variables / Arrays
    public var foodItem: [String] = [] //holds the list of the food items
    public var shoppingList: [(String, String, String, String)] = [
        ("Cupboard","Baked Beans","Y","4 tins"),
        ("Freezer","Pork Sausages","Y","6 pk"),
        ("Fridge","Mushrooms","Y","1 pk"),
        ("Bathroom","Toilet paper","Y","12 rolls"),
        ("Bathroom","Tooth paste","Y","1 tube"),
        ("Bakery","Bagels","Y","4 pk"),
        ("Freezer","Oven Chips","Y","1.5kg"),
        ("Bakery","Sliced Bread","Y","1 loaf"),
        ("Cupboard","Tea","Y","240 bags"),
        ("Fridge","Milk","Y","6 pints"),
        ("Fridge","Eggs","Y","1/2 doz"),
        ("Fridge","Butter","Y","250g"),
        ("Cupboard","Taco's","Y","1 pk"),
        ("Bakery","Soft Rolls","Y","4 rolls"),
        ("Bathroom","Hand soap","Y","Bar"),
        ("Fridge","Cheese","Y","500g"),
        ("Fridge","Ham","Y","1 pk"),
        ("Bathroom","Shower gel","Y","250g"),
        ("Household","Paracetamol","Y","1 pk of 16")]
    
    //MARK: - Actions
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        alert.addTextField { (foodItemCell) in
            foodItemCell.placeholder = "enter Food Item"
        }
        let action = UIAlertAction(title: "Add to list", style: .destructive) { (_) in
            guard let addedFoodItem = alert.textFields?.last?.text else { return }
            print(addedFoodItem)
            self.shoppingList.append(("Added",addedFoodItem,"Y","1 off"))
            self.updateShoppingList()   //ReSort shopping list
            self.tableView.reloadData() //Display all data including the new
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // sort the fooditems alphabetically
        updateShoppingList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleString = "Items needed from Tesco"
        return titleString.capitalized
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row].1
        cell.detailTextLabel?.text = shoppingList[indexPath.row].3
        switch shoppingList[indexPath.row].2 {
        case "Y":
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
            cell.detailTextLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        case "N":
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
            
        default:
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = UIColor.gray
        }
        return cell
    }
    
    // MARK: Selected Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch shoppingList[indexPath.row].2 {
        case "Y":
            self.shoppingList[indexPath.row].2 = "N"
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
        case "N":
            self.shoppingList[indexPath.row].2 = "Y"
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.left)
        default:
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }
    
    //MARK: - update the shopping list
    func updateShoppingList() {
        shoppingList.sort{ $1.1 > $0.1 }
    }

}

