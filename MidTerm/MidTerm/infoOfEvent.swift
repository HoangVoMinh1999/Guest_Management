//
//  infoOfEvent.swift
//  MidTerm
//
//  Created by Vo Minh Hoang on 11/10/19.
//  Copyright © 2019 Vo Minh Hoang. All rights reserved.
//

import Foundation
import RealmSwift

class infoEvent : Object{
    @objc dynamic var name: String?
    @objc dynamic var font: String? 
    @objc dynamic var fontSize: String?
    @objc dynamic var fontColor: String?
}
	
class Guest:Object{
    @objc dynamic var firstname:String?
    @objc dynamic var lastname:String?
    @objc dynamic var guests:String?
    @objc dynamic var table:String?
    @objc dynamic var section:String?
}
