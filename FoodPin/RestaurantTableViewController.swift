//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 7/7/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    lazy var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    var checkInAction = UIAlertAction()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
//        if restaurantIsVisited[indexPath.row]
//        {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Create option menu
        let optionMenu = UIAlertController(title: "Are u sure?", message: "What do you want to do?", preferredStyle: .actionSheet)
        //Add action to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        //Add Call Action
        //Describe the handler for call action
        
        let callHandler = { (action:UIAlertAction!)-> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Try again later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertMessage, animated: true)
        }
        
        let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .default, handler: callHandler)
        
        let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check In" : "Check In"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: { (action:UIAlertAction) -> Void in
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        })
        
        //Old checkInAction inplementation
//
//        let checkInHandler = { (action:UIAlertAction!) -> Void in
//            self.restaurantIsVisited[indexPath.row] = true
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .checkmark
//        }
//
//        let undoCheckInHandler = { (action:UIAlertAction!) -> Void in
//            self.restaurantIsVisited[indexPath.row] = false
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .none
//        }
//
//        let undoCheckInAlert = UIAlertAction(title: "Undo Check In", style: .default, handler: undoCheckInHandler)
//        let checkInAlert = UIAlertAction(title: "Check In", style: .default, handler: checkInHandler)
//        checkInAction = restaurantIsVisited[indexPath.row] ? undoCheckInAlert : checkInAlert
        
        optionMenu.addAction(checkInAction)
        optionMenu.addAction(callAction)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            restaurantIsVisited.remove(at: indexPath.row)
//            restaurantNames.remove(at: indexPath.row)
//            restaurantTypes.remove(at: indexPath.row)
//            restaurantImages.remove(at: indexPath.row)
//            restaurantLocations.remove(at: indexPath.row)
//        }
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }
//
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Social shareing
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "Just checking in at \(self.restaurantNames[indexPath.row])"
            if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]){
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare],
                                                                  applicationActivities: nil)
                self.present(activityController, animated: true)
            }
        })
        
        //Delete button
        let deleteButton = UITableViewRowAction(style: .destructive, title: "Delete", handler: {(action, indexPath) -> Void in
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        shareAction.backgroundColor = UIColor.blue
        deleteButton.backgroundColor = UIColor.gray
        return [deleteButton, shareAction]
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
















