//
//  ContactsTableViewController.swift
//  TabBar_Contacts
//
//  Created by Yernar Dyussenbekov on 30.09.2024.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    var arrayContacts = [Person(name: "Yernar", surname: "Dyussenbekov", phoneNumber: "+77001234567", isFavorite: true),                 Person(name: "Elon", surname: "Musk", phoneNumber: "+7 702 1234567", isFavorite: false)]
    
    
   // var arrayContacts = [Person()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            if let data = UserDefaults.standard.data(forKey: "Contacts"){
            } else {
                let encodedData = try JSONEncoder().encode(arrayContacts)
                UserDefaults.standard.setValue(encodedData, forKey: "Contacts")
                tableView.reloadData()
            }
        } catch {
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayContacts.count
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            if let data = UserDefaults.standard.data(forKey: "Contacts"){
                let array = try JSONDecoder().decode([Person].self, from: data)
                arrayContacts = array
                tableView.reloadData()
            } else {
            }
        } catch {
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = arrayContacts[indexPath.row].name + " " + arrayContacts[indexPath.row].surname
        cell.detailTextLabel?.text = arrayContacts[indexPath.row].phoneNumber
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let EditContactView = storyboard?.instantiateViewController(identifier: "EditContactView") as! EditViewController
        //переход в экран редактирования
        EditContactView.index = indexPath.row
        navigationController?.show(EditContactView, sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            arrayContacts.remove(at: indexPath.row)
            do {
                let encodedData = try JSONEncoder().encode(arrayContacts)
                UserDefaults.standard.set(encodedData, forKey: "Contacts")
                tableView.deleteRows(at: [indexPath], with: .fade)
            }catch{
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        } 
        
    }
    
    
    
    
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
