//
//  CalendarViewController.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CalendarViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: UICollectionViewDataSource

  let numberOfWeekdays = 7

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    return multipleOf(numberOfWeekdays + numberOfDaysInMonth + paddingDays, numberOfWeekdays)
  }

  override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
    let index = indexPath.indexAtPosition(1)
    if index < 7 {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("weekday", forIndexPath:indexPath) as WeekdayCell
      let formatter = NSDateFormatter()
      cell.label.text = formatter.shortWeekdaySymbols[index] as String
      return cell
    } else {
      let day = index + 1 - paddingDays - 7
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("day", forIndexPath:indexPath) as DayCell
      cell.label.text = (day >= 1 && day <= numberOfDaysInMonth) ? String(day) : ""
      return cell
    }
  }
  
  // MARK: UICollectionViewDelegate
  
  /*
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  func collectionView(collectionView: UICollectionView!, shouldHighlightItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment this method to specify if the specified item should be selected
  func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  func collectionView(collectionView: UICollectionView!, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
  return false
  }
  
  func collectionView(collectionView: UICollectionView!, canPerformAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) -> Bool {
  return false
  }
  
  func collectionView(collectionView: UICollectionView!, performAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) {
  
  }
  */

  func collectionView(cv: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
    if indexPath.indexAtPosition(1) < 7 {
      return CGSize(width: 44, height: 24)
    } else {
      return CGSize(width: 44, height: 48)
    }
  }

  lazy var paddingDays: Int = {
    let calendar = NSCalendar.currentCalendar()
    let today = NSDate()
    let comps = calendar.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: today)
    comps.day = 1
    let firstDay = calendar.dateFromComponents(comps)
    let firstComps = calendar.components(.CalendarUnitWeekday, fromDate: firstDay!)
    return firstComps.weekday - 1
  }()

  lazy var numberOfDaysInMonth: Int = {
    let calendar = NSCalendar.currentCalendar()
    let today = NSDate()
    let days = calendar.rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth, forDate: today)
    println("days \(days.length)")
    return days.length
  }()

  func multipleOf(x: Int, _ y: Int) -> Int {
    return (x + y - 1) / y * y
  }
}
