//
//  HelpViewController.swift
//  CoffeeBud
//
//  Created by Sean McCalgan on 2017/08/08.
//  Copyright © 2017 Sean McCalgan. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class HelpContactViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var details: HelpDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.nameLabel.text = "Name: "
        self.emailLabel.text = "Email: "
        self.phoneLabel.text = "Phone: "
        
        navigationItem.title = "Contact Us"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emailButton(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["sean.mccalgan@gmail.com"])
            mail.setMessageBody("<p>Help Request from CoffeeBud App</p>", isHTML: true)
            
            self.present(mail, animated: true)
        } else {
            // show failure alert
            let alert = UIAlertController(title: "Alert", message: "Cannot Send Mail", preferredStyle: UIAlertControllerStyle.alert)
            
            self.present(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        //let dataPoint1 = textEntryA.text?.replacingOccurrences(of: " ", with: "+")
        //let dataPoint2 = textEntryB.text?.replacingOccurrences(of: " ", with: "+")
        
        let urlString = URL(string: "http://jsonplaceholder.typicode.com/users/1")

        URLSession.shared.dataTask(with:urlString!) { (data, response, error) in
            if error != nil {
                print(error ?? "URL Error")
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print(parsedData)
                    //let id = parsedData["id"] as! Int
                    let name = parsedData["name"] as! String
                    let email = parsedData["email"] as! String
                    let phone = parsedData["phone"] as! String
                    
                    print(name)
                    
                    DispatchQueue.main.async {
                        self.nameLabel.text = "Name: " + name
                        self.emailLabel.text = "Email: " + email
                        self.phoneLabel.text = "Phone: " + phone
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
}
