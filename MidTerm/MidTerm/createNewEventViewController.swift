//
//  createNewEventViewController.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/10/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import ColorPickTip
import SCLAlertView

class GuestCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
}

class createNewEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = realm.objects(Guest.self)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = realm.objects(Guest.self)
        let guest = list[indexPath.row]
        let cell = guestData.dequeueReusableCell(withIdentifier: "guestCell", for: indexPath) as! GuestCell
        cell.nameLabel.text = "\(guest.lastname ?? "") \(guest.firstname ?? "")"
        cell.guestsLabel.text = "\(guest.guests!)"
        cell.tableLabel.text = "\(guest.table!)"
        cell.sectionLabel.text = "\(guest.section!)"
        return cell
    }
    

    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var fontSize: UISlider!
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var guestData: UITableView!
    @IBOutlet weak var fontText: UILabel!
    @IBOutlet weak var colorText: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    
    let realm = try! Realm()
    var selectedFont: String = "Arial"
    var fsize: Int? = 20
    var fcolor: String? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).UIColorToString()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let event = realm.objects(infoEvent.self)
        if (event.count == 0) {
            actionTitle.text = "CREATE NEW EVENT"
            fontText.text = selectedFont
            fontText.font = UIFont(name: selectedFont, size: 16)
            fontSizeLabel.text = String(fsize!)
            colorText.backgroundColor = fcolor?.StringToUIColor()
        }
        else {
            actionTitle.text = "EDIT CURRENT EVENT"
            eventName.text = event[0].name
            selectedFont = event[0].font!
            fontText.text = event[0].font
            fontText.font = UIFont(name: event[0].font!, size: 17)
            fsize = Int(event[0].fontSize!)
            fontSizeLabel.text = event[0].fontSize
            fcolor = event[0].fontColor
            colorText.backgroundColor = event[0].fontColor?.StringToUIColor()
        }
        
        guestData.delegate = self
        guestData.dataSource = self
       
        guestData.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fontButton(_ sender: Any) {
        let alertView = UIAlertController(
            title: "Select Font",
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .alert)

        let fontPicker = UIPickerView(frame: CGRect(x: 0, y: 50, width: 260, height: 162))
        fontPicker.dataSource = self
        fontPicker.delegate = self

        // comment this line to use white color
        fontPicker.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

        alertView.view.addSubview(fontPicker)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            let event = self.realm.objects(infoEvent.self)
            if (event.count == 0){
                self.selectedFont = "Helvetica"
                self.fontText.text = self.selectedFont
                self.fontText.font = UIFont(name: self.selectedFont, size: 16)
            }
            else {
                self.selectedFont = event[0].font!
                self.fontText.text = self.selectedFont
                self.fontText.font = UIFont(name: self.selectedFont, size: 16)
            }
        }
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        alertView.preferredAction = okAction
        
        present(alertView, animated: true, completion: { () in
            fontPicker.frame.size.width = alertView.view.frame.size.width
        })
    }
    
    //-----
    
    @IBAction func changefSize(_ sender: Any) {
        fontSize.minimumValue = 15
        fontSize.maximumValue = 60
        fontSize.isContinuous = true
        let slider = sender as! UISlider
        fsize = Int(slider.value)
        fontSizeLabel.text = "\(fsize!)"
    }
    
    //-----
    
    @IBAction func changefColor(_ sender: Any) {
        let palette = Colors.color1
         let options = ColorPickTip.Options()
                
         let colorPickTipVC = ColorPickTipController(palette: palette, options: options)
         colorPickTipVC.popoverPresentationController?.delegate = colorPickTipVC
         colorPickTipVC.popoverPresentationController?.sourceView = sender as? UIView
         colorPickTipVC.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
         self.present(colorPickTipVC, animated: true, completion: nil)
         
         colorPickTipVC.selected = {
         color, index in
         guard color != nil else {return}
         self.fcolor = color!.UIColorToString()
         self.colorText.backgroundColor = self.fcolor!.StringToUIColor()
        }
    }
 //------------
    
    @IBAction func saveButton(_ sender: Any) {
        let event = realm.objects(infoEvent.self)
            if (event.count == 0) {
                if (eventName.text == ""){
                    SCLAlertView().showError("Error", subTitle: "Please enter your event name!!!")
                }
                else {
                    let myEvent = infoEvent()
                    myEvent.name = eventName.text
                    myEvent.font = selectedFont
                    myEvent.fontSize = String(fsize!)
                    myEvent.fontColor = fcolor
                    try! realm.write {
                        realm.add(myEvent)
                    }
                    SCLAlertView().showInfo("Success", subTitle: "Your event has been ADDED!")
                    self.dismiss(animated: false, completion: nil)
                }
            }
            else {
                if (eventName.text == ""){
                    SCLAlertView().showError("Error", subTitle: "Please enter your event name!!!")
                }
                else {
                    try! realm.write {
                        event[0].name = eventName.text
                        event[0].font = selectedFont
                        event[0].fontSize = String(fsize!)
                        event[0].fontColor = fcolor
                    }
                    SCLAlertView().showInfo("Success", subTitle: "Your event has been UPDATED!")
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    
    @IBAction func exitButton(_ sender: Any) {
        let event = realm.objects(infoEvent.self)
        if (event.count == 0) {
            let alert = SCLAlertView()
            alert.showWarning("Warning", subTitle: "Event is not created!!!")
            try! realm.write{
                realm.deleteAll()
            }
        }
        //performSegue(withIdentifier: "unwindToAdminView", sender: self)
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        @IBAction func unwindToCreateEventView(segue: UIStoryboardSegue){
        guestData.reloadData()
    }
    
    
}

extension createNewEventViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UIFont.familyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFont = UIFont.familyNames[row]
        fontText.text = selectedFont
        fontText.font = UIFont(name: selectedFont, size: 16)
    }
}
//------
extension UIColor {
    func UIColorToString() -> String {
        let components = self.cgColor.components
        return "[\(components![0]), \(components![1]), \(components![2]), \(components![3])]"
    }
}

extension String {
    func StringToUIColor() -> UIColor {
        let componentsString = self.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let components = componentsString.components(separatedBy: ", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                     green: CGFloat((components[1] as NSString).floatValue),
                      blue: CGFloat((components[2] as NSString).floatValue),
                     alpha: CGFloat((components[3] as NSString).floatValue))
    }
}


