//
//  Task.swift
//  JaCal
//
//  Created by Jake Song on 8/28/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var count: Int32
    @NSManaged var icon: String
    @NSManaged var period: Int16
    @NSManaged var title: String
    @NSManaged var dones: NSSet

}
