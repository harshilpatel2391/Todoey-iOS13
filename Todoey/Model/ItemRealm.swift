//
//  ItemRealm.swift
//  Todoey
//
//  Created by Vaishali on 2020-06-15.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class ItemRealm: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "items")
}
