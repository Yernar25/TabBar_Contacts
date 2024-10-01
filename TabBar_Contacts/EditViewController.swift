//
//  ViewController.swift
//  TabBar_Contacts
//
//  Created by Yernar Dyussenbekov on 30.09.2024.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var isFavoriteSwitch: UISwitch!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var index = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            if let data = UserDefaults.standard.data(forKey: "Contacts"){
                let array = try JSONDecoder().decode([Person].self, from: data)
                nameTextField.text = array[index].name
                surnameTextField.text = array[index].surname
                numberTextField.text = array[index].phoneNumber
                isFavoriteSwitch.isOn = array[index].isFavorite
            }
        } catch {
        }
    }
    
    

    @IBAction func editContact(_ sender: Any) {
        if (nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || numberTextField.text!.isEmpty) {
            statusLabel.textColor = .red
            statusLabel.text = "Enter name, surname number"
        } else {
            do {
                if let data = UserDefaults.standard.data(forKey: "Contacts"){
                    var array = try JSONDecoder().decode([Person].self, from: data)
                    array[index].name = nameTextField.text!
                    array[index].surname = surnameTextField.text!
                    array[index].phoneNumber = numberTextField.text!
                    array[index].isFavorite = isFavoriteSwitch.isOn
                    
                    let encodedData = try JSONEncoder().encode(array)
                    UserDefaults.standard.set(encodedData, forKey: "Contacts")
                    
                    statusLabel.textColor = .green
                    statusLabel.text = "Contact \(array[index].name) edited"
                }
            } catch {
            }
        }
    }
    
}

