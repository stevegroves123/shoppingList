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
    @IBOutlet weak var plusButton: UIButton!
    
    //MARK: - Variables / Arrays
    public var foodItem: [String] = [] //holds the list of the food items
    public var shoppingList: [(String, String, String)] = [
        ("Cupboard","Baked Beans","Y"),
        ("Freezer","Pork Sausages","Y"),
        ("Fridge","Mushrooms","Y"),
        ("Bathroom","Toilet paper","Y"),
        ("Bakery","Bagels","Y"),
        ("Freezer","Oven Chips","Y"),
        ("Bakery","Sliced Bread","Y"),
        ("Bathroom","Shampoo","Y"),
        ("Bathroom","Conditioner","Y"),
        ("Cupboard","Tea","Y"),
        ("Fridge","Milk","Y"),
        ("Fridge","Eggs","Y"),
        ("Fridge","Butter","Y"),
        ("Cupboard","Taco's","Y"),
        ("Bakery","Soft Rolls","Y"),
        ("Bathroom","Soap","Y"),
        ("Bathroom","Shower gel","Y"),
        ("Household","Kitchen cleaner, spray","Y"),
        ("Household","Kitchen bleach","Y"),
        ("Household","Paracetamol","Y")]
    
    //MARK: - Actions
    @IBAction func plusButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        alert.addTextField { (foodItemCell) in
            foodItemCell.placeholder = "enter Food Item"
        }
        let action = UIAlertAction(title: "Add to list", style: .destructive) { (_) in
            guard let addedFoodItem = alert.textFields?.last?.text else { return }
            print(addedFoodItem)
            self.shoppingList.append(("Added",addedFoodItem,"Y"))
            self.foodItem = []          //Clear out existitng array
            self.updateShoppingList()   //ReSort shopping list and reCreate foodItem array
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
        return foodItem.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleString = "Items needed from Tesco"
        return titleString.uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell", for: indexPath)
        cell.textLabel?.text = foodItem[indexPath.row]
        switch shoppingList[indexPath.row].2 {
        case "Y":
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            cell.textLabel?.textColor = UIColor.black
        case "N":
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = UIColor.lightGray
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
        
        for j in 0...shoppingList.count - 1 {
            foodItem.append(shoppingList[j].1)
        }
    }

}

