//
//  CategoryRealm.swift
//  Todoey
//
//  Created by Vaishali on 2020-06-15.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealm: Object {
    @objc dynamic var name : String = ""
    var items = List<ItemRealm>()
}
