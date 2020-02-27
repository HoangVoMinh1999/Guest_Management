//
//  adminViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/13/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class adminViewController: UIViewController {
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createNewButton(_ sender: Any) {
        let event = realm.objects(infoEvent.self)
        if (event.count == 0){
            let story = self.storyboard
            let vc = story?.instantiateViewController(withIdentifier: "createNewEventViewController") as! createNewEventViewController

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        else {
            let alert = SCLAlertView()
            alert.addButton("OK") { () -> Void in
                try! self.realm.write {
                    self.realm.deleteAll()
                }
                let story = self.storyboard
                let vc = story?.instantiateViewController(withIdentifier: "createNewEventViewController") as! createNewEventViewController
                
                vc.modalPresentationStyle = .fullScreen
                
                self.present(vc, animated: false)
            }
            alert.showWarning("Error", subTitle: "Creating new event will delete all the information from the previous or current event in the app")
        }
    }
    
    @IBAction func editCurrentButton(_ sender: Any) {
        let event = realm.objects(infoEvent.self)
        if (event.count == 1){
            let story = self.storyboard
            let vc = story?.instantiateViewController(withIdentifier: "createNewEventViewController") as! createNewEventViewController

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        else {
            SCLAlertView().showError("Error", subTitle: "No data to edit!!!")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
