//
//  addGuestViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/10/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class addGuestViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var guestTextField: UITextField!
    @IBOutlet weak var tableTextField: UITextField!
    @IBOutlet weak var sectionTextField: UITextField!
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if (firstnameTextField.text == "" || lastnameTextField.text == "" || tableTextField.text == "" || sectionTextField.text == ""){
            SCLAlertView().showError("Error", subTitle: "Don't leave text fields blank!!!")
        }
        else{
            let g = Guest()
            g.firstname = firstnameTextField.text
            g.lastname = lastnameTextField.text
            g.guests=guestTextField.text
            g.table=tableTextField.text
            g.section=sectionTextField.text
            
            try! realm.write{
                realm.add(g)
            }
            SCLAlertView().showInfo("Added", subTitle: "Successfully")
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToCreateNewEvent", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
