//
//  guestViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/14/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import RealmSwift

class guestViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event = realm.objects(infoEvent.self)
        titleLabel.text = event[0].name
        // Do any additional setup after loading the view.
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
