//
//  HelpDetail.swift
//  CoffeeBud
//
//  Created by Sean McCalgan on 2017/08/29.
//  Copyright © 2017 Sean McCalgan. All rights reserved.
//

import UIKit

class HelpDetail {

    //MARK: Properties
    
    var name: String
    var identifier: String
    
    //MARK: Initialization
    
    init?(name: String, identifier: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The identifier must not be empty
        guard !identifier.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.identifier = identifier

    }

}
