//
//  detailViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/14/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import RealmSwift

class peopleSameTableCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    
}

class detailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = realm.objects(Guest.self).filter("table = '\(tablenum)'")
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = realm.objects(Guest.self).filter("table = '\(tablenum)'")
        let guest = list[indexPath.row]
        let cell = tableName.dequeueReusableCell(withIdentifier: "peopleSameTableCell", for: indexPath) as! peopleSameTableCell
        cell.nameLabel.text = "\(guest.lastname ?? "") \(guest.firstname ?? "")"
        cell.guestsLabel.text = guest.guests
        return cell
    }
    
    @IBOutlet weak var nameGuestLabel: UILabel!
    @IBOutlet weak var tableNumLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var tableName: UITableView!
    
    let realm = try! Realm()
    
    var lastname: String = ""
    var firstname: String = ""
    var tablenum: String = ""
    var guests: String = ""
    var guestsection: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event = realm.objects(infoEvent.self)
        
        nameGuestLabel.text = "\(lastname) \(firstname)"
        nameGuestLabel.font = UIFont(name: event[0].font!, size: CGFloat((event[0].fontSize! as NSString).integerValue))
        nameGuestLabel.textColor = event[0].fontColor!.StringToUIColor()
        
        tableNumLabel.text = tablenum
        guestsLabel.text = guests
        sectionLabel.text = guestsection

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
