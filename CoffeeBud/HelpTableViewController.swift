//
//  HelpTableViewController.swift
//  CoffeeBud
//
//  Created by Sean McCalgan on 2017/08/08.
//  Copyright © 2017 Sean McCalgan. All rights reserved.
//

import UIKit
import os.log

class HelpTableViewController: UITableViewController {

    var details = [HelpDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadItems()
        
        navigationItem.title = "Help Center"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return details.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell", for: indexPath) as! HelpTableViewCell

        // Configure the cell...
        
        let detail = details[indexPath.row]
        cell.cellLabel.text = detail.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let detail = details[indexPath.row]

        switch detail.name {
        case "About":
            self.performSegue(withIdentifier: "showHelpAbout", sender: indexPath);
        case "Contact Us":
            self.performSegue(withIdentifier: "showHelpContact", sender: indexPath);
        case "FAQ":
            self.performSegue(withIdentifier: "showHelpFAQ", sender: indexPath);
        default:
            return
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        return false
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

    }*/
    
    private func loadItems() {
        
        guard let item1 = HelpDetail(name: "About", identifier: "showHelpAbout") else {
            fatalError("Unable to instantiate item1")
        }
        
        guard let item2 = HelpDetail(name: "FAQ", identifier: "showHelpFAQ") else {
            fatalError("Unable to instantiate item2")
        }
        
        guard let item3 = HelpDetail(name: "Contact Us", identifier: "showHelpContact") else {
            fatalError("Unable to instantiate item3")
        }
        
        details += [item1, item2, item3]
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
