//
//  AddViewController.swift
//  TabBar_Contacts
//
//  Created by Yernar Dyussenbekov on 30.09.2024.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    //скрыть клавиатуру
    @objc func hideKeyboard() {
            view.endEditing(true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        statusLabel.text = ""
    }
    
   
    
    @IBAction func addContact(_ sender: Any) {
        let name = nameTextField.text!
        let surname = surnameTextField.text!
        let phoneNumber = numberTextField.text!
            
        if (name.isEmpty || surname.isEmpty || phoneNumber.isEmpty) {
            statusLabel.textColor = .red
            statusLabel.text = "Enter name, surname number"
        } else {
            let newContact = Person(name: name, surname: surname, phoneNumber: phoneNumber)
            
            do {
                if let data = UserDefaults.standard.data(forKey: "Contacts"){
                    var array = try JSONDecoder().decode([Person].self, from: data)
                    array.append(newContact)
                    let encodedData = try JSONEncoder().encode(array)
                    UserDefaults.standard.set(encodedData, forKey: "Contacts")
                } else {
                    let encodedData = try JSONEncoder().encode([newContact])
                    UserDefaults.standard.setValue(encodedData, forKey: "Contacts")
                }
                statusLabel.textColor = .green
                statusLabel.text = "Added contact \(name)"
                
            } catch {
            }
            
            nameTextField.text = ""
            surnameTextField.text = ""
            numberTextField.text = ""
            
        }
            
        
        
    }
    


}
