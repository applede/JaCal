//
//  global.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Foundation

var thisMonth: String = {
  let today = NSDate()
  let calendar = NSCalendar.currentCalendar()
  let comps = calendar.components(.CalendarUnitMonth, fromDate: today)
  let formatter = NSDateFormatter()
  let str = formatter.monthSymbols[comps.month - 1] as String
  return str
}()
