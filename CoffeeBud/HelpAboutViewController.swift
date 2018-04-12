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

class HelpAboutViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    var details: HelpDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        navigationItem.title = "About"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
