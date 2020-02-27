//
//  searchViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/14/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView



class searchViewController: UIViewController {
    var select: String = ""
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        switch (sender.tag){
        case 0: select = "A"
        case 1: select = "B"
        case 2: select = "C"
        case 3: select = "D"
        case 4: select = "E"
        case 5: select = "F"
        case 6: select = "G"
        case 7: select = "H"
        case 8: select = "I"
        case 9: select = "J"
        case 10: select = "K"
        case 11: select = "L"
        case 12: select = "M"
        case 13: select = "N"
        case 14: select = "O"
        case 15: select = "P"
        case 16: select = "Q"
        case 17: select = "R"
        case 18: select = "S"
        case 19: select = "T"
        case 20: select = "U"
        case 21: select = "V"
        case 22: select = "W"
        case 23: select = "X"
        case 24: select = "Y"
        case 25: select = "Z"
        default:
            select = ""
        }
        
        let checkList = realm.objects(Guest.self).filter("lastname BEGINSWITH '\(select)'")
        if (checkList.count == 0) {
            SCLAlertView().showInfo("Infomation", subTitle: "No guest found '\(select)'")
        }
        else {
            let story = self.storyboard
            let VC = story?.instantiateViewController(withIdentifier: "selectNameViewController") as! selectNameViewController
            VC.modalPresentationStyle = .fullScreen
            VC.select = select
            self.present(VC, animated: false)
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

}
