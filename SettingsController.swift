//
//  SettingsController.swift
//  CoffeeBud
//
//  Created by Sean McCalgan on 2017/07/27.
//  Copyright © 2017 Sean McCalgan. All rights reserved.
//

import UIKit

class SettingsController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var cityEntry: UITextField!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var questionSwitch1: UISwitch!
    @IBOutlet weak var questionSwitch2: UISwitch!
    
    var users: User!
    var userID: Int = 0
    
    let pickerData = [["Cape Town","Durban","Johannesburg","Port Elizabeth","George","Stellenbosch"],["South Africa"]]
    let cityComponent = 0
    let countryComponent = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
    
        users = DBManager.shared.loadUser()
        print(users)
        if (users == nil) {
            nameEntry.text = nil
            cityEntry.text = nil
            cityPicker.selectedRow(inComponent: 0)
            questionSwitch1.isOn = false
            questionSwitch2.isOn = false
        } else {
            userID = users.userID
            nameEntry.text = users.userName
            cityEntry.text = users.userCity
            cityPicker.selectedRow(inComponent: 0)
            
            if (users.userSel1 == 1) {
                questionSwitch1.isOn = true
            } else {
                questionSwitch1.isOn = false
            }
            if (users.userSel2 == 1) {
                questionSwitch2.isOn = true
            } else {
                questionSwitch2.isOn = false
            }
        }
        
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "userNameKey")
        print(name ?? "No name found")
        
        defaults.set("Sean", forKey: "userNameKey")
        
        let name2 = defaults.string(forKey: "userNameKey")
        print(name2 ?? "No name found")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int
        ) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        updateLabel()
    }
    
    //MARK - Instance Methods
    func updateLabel() {
        let city = pickerData[cityComponent][cityPicker.selectedRow(inComponent: 0)]
        let country = pickerData[countryComponent][cityPicker.selectedRow(inComponent: 1)]
        cityEntry.text = city + ", " + country
    }
    
    func updateDatabase() {
        let storageName = nameEntry.text
        let storageCity = cityEntry.text
        var storageQ1 = 0
        var storageQ2 = 0
        if (questionSwitch1.isOn) {
            storageQ1 = 1
        } else {
            storageQ1 = 0
        }
        if (questionSwitch2.isOn) {
            storageQ2 = 1
        } else {
            storageQ2 = 0
        }
        
        users = DBManager.shared.loadUser()
        if (users == nil) {
            DBManager.shared.insertUserData(userName: storageName!, userCity: storageCity!, userSel1: storageQ1, userSel2: storageQ2)
        } else {
            DBManager.shared.updateUser(withID: userID, userName: storageName!, userCity: storageCity!, userSel1: storageQ1, userSel2: storageQ2)
        }
        
        users = DBManager.shared.loadUser()
        print(users)
        
    }
    
    @IBAction func nameAction(_ sender: Any) {
        updateDatabase()
    }
    
    @IBAction func cityAction(_ sender: Any) {
        updateDatabase()
    }
    

    @IBAction func questionSwitch1Action(_ sender: Any) {
        updateDatabase()
    }

    @IBAction func questionSwitch2Action(_ sender: Any) {
        updateDatabase()
    }
    
    
}


