//
//  TaskDone.swift
//  JaCal
//
//  Created by Jake Song on 8/28/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Foundation
import CoreData

class TaskDone: NSManagedObject {

    @NSManaged var date: NSTimeInterval
    @NSManaged var task: Task?

}
