//
//  selectNameViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/14/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import RealmSwift

class selectNameViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let realm = try! Realm()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredGuestList = realm.objects(Guest.self).filter("lastname BEGINSWITH '\(select)'")
        return filteredGuestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = realm.objects(infoEvent.self)
        let filteredGuestList = realm.objects(Guest.self).filter("lastname BEGINSWITH '\(select)'")
        let guest = filteredGuestList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "letterGuestCell", for: indexPath)
        cell.textLabel?.text = "\(guest.lastname ?? "") \(guest.firstname ?? "")"
        cell.textLabel?.font = UIFont(name: event[0].font!, size: CGFloat((event[0].fontSize! as NSString).integerValue))
        cell.textLabel?.textColor = event[0].fontColor!.StringToUIColor()
        return cell
    }
    
    var select : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableName.delegate = self
        tableName.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableName: UITableView!
    
    @IBAction func homeButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let vc = segue.destination as? detailViewController else { return }
            guard let indexPath = tableName.indexPathForSelectedRow else { return }
            let list = realm.objects(Guest.self).filter("lastname BEGINSWITH '\(select)'")
            let guest = list[indexPath.row]
            vc.lastname = "\(guest.lastname ?? "")"
            vc.firstname = "\(guest.firstname ?? "")"
            vc.tablenum = guest.table!
            vc.guests = guest.guests!
            vc.guestsection = guest.section!
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
