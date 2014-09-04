//
//  CalendarViewController.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

//let reuseIdentifier = "Cell"

class CalendarViewController: UICollectionViewController {
//  var 한일들: [TaskDone] = []
  var 에_한일들: [NSTimeInterval: [TaskDone]] = [:]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
//    self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    // Do any additional setup after loading the view.
    let 기록들 = app.기록들()
    for 기록 in 기록들 {
      추가(에: 기록.date, 을: 기록)
      println("\(기록.task?.title) \(기록.date)")
    }
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

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return multipleOf(numberOfWeekdays + numberOfDaysInMonth + paddingDays, numberOfWeekdays)
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let index = indexPath.indexAtPosition(1)
    if index < 7 {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("weekday", forIndexPath:indexPath) as WeekdayCell
      let formatter = NSDateFormatter()
      cell.label.text = formatter.shortWeekdaySymbols[index] as? String
      return cell
    } else {
      let day = index + 1 - paddingDays - 7
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("day", forIndexPath:indexPath) as DayCell
      cell.label.text = (day >= 1 && day <= numberOfDaysInMonth) ? String(day) : ""

      let 달력 = NSCalendar.currentCalendar()
      let 분해된 = 달력.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: NSDate())
      분해된.day = day
      let 그날 = 달력.dateFromComponents(분해된)!.timeIntervalSinceReferenceDate
      에_한일들[그날]?.각각의 { cell.icon.text = $0.task?.icon }
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
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as DayCell
    if let 선택된_목표 = app.selectedTask() {
      if cell.label.text != "" {
        let 날짜 = 문자열에서(cell.label.text!)
        if let 기록 = 찾은(중에: &에_한일들[날짜], 를: 선택된_목표) {
          app.삭제(을: 기록)
        } else {
          let 기록 = app.한걸로(를: 선택된_목표, 에: 날짜)
          추가(에: 날짜, 을: 기록)
        }
        cell.icon.text = 아이콘들(에서: 에_한일들[날짜])
      }
    }
  }

  func 추가(에 날짜: NSTimeInterval, 을 기록: TaskDone) {
    if 에_한일들[날짜] == nil {
      에_한일들[날짜] = [기록]
    } else {
      에_한일들[날짜]?.append(기록)
    }
  }

  func 찾은(inout 중에 한일들: [TaskDone]?, 를 목표: Task) -> TaskDone? {
    if var 일들 = 한일들 {
      for (ㅇ, 기록) in enumerate(일들) {
        if 기록.task == 목표 {
          일들.removeAtIndex(ㅇ)
          return 기록
        }
      }
    }
    return nil
  }

  func 아이콘들(에서 한일들: [TaskDone]?) -> String {
    if let 일들 = 한일들 {
      return 일들.reduce("") { 문자열, 기록 in
        if 기록.task == nil {
          return 문자열
        } else {
          return 문자열 + 기록.task!.icon
        }
      }
    }
    return ""
  }

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
    return days.length
  }()

  func multipleOf(x: Int, _ y: Int) -> Int {
    return (x + y - 1) / y * y
  }

  func 문자열에서(문자열: String) -> NSTimeInterval {
    let 달력 = NSCalendar.currentCalendar()
    let 오늘 = NSDate()
    let 구성요소 = 달력.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitTimeZone, fromDate: 오늘)
    구성요소.day = 문자열.toInt()!
    return 달력.dateFromComponents(구성요소)!.timeIntervalSinceReferenceDate
  }
}
