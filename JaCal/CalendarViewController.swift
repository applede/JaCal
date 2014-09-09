//
//  CalendarViewController.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

//let reuseIdentifier = "Cell"
let 달력 = NSCalendar.currentCalendar()
let 날_플래그 = NSCalendarUnit.CalendarUnitEra | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay

class CalendarViewController: UICollectionViewController {
//  var 한일들: [TaskDone] = []
  var 에_한일들: [NSTimeInterval: [TaskDone]] = [:]
  var 첫칸_날: NSTimeInterval = 0
  var 보여주는_달: Int = 0
  var 오늘: NSTimeInterval = 0
  var 달_첫날: NSDate = NSDate()

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
    오늘 = 오늘_계산()
    달_첫날 = 오늘에서_달의_첫날()
    (첫칸_날, 보여주는_달) = 달_변화에_따라(달_첫날)
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
    return multipleOf(numberOfWeekdays + 달_날수(달_첫날) + 앞에_비는_날수(달_첫날), numberOfWeekdays)
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let index = indexPath.row
    if index < 7 {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("weekday", forIndexPath:indexPath) as WeekdayCell
      let formatter = NSDateFormatter()
      cell.label.text = formatter.shortWeekdaySymbols[index] as? String
      return cell
    } else {
      let (날, 월, 일) = 인덱스에서(index - 7)
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("day", forIndexPath:indexPath) as DayCell
      if 월 != 보여주는_달 {
        cell.label.textColor = UIColor.grayColor()
        cell.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
      } else if 날 == 오늘 {
        cell.label.textColor = UIColor.darkTextColor()
        cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
      } else {
        cell.label.textColor = UIColor.darkTextColor()
        cell.backgroundColor = UIColor.whiteColor()
      }
      cell.label.text = String(일)
      cell.icon.text = 아이콘들(에서: 에_한일들[날])
      return cell
    }
  }

  func 인덱스에서(인덱스: Int) -> (NSTimeInterval, Int, Int) {
    let 날 = 첫칸_날 + Double(인덱스) * 60 * 60 * 24
    let 분해 = 달력.components(.CalendarUnitMonth | .CalendarUnitDay, fromDate: NSDate(timeIntervalSinceReferenceDate: 날))
    return (날, 분해.month, 분해.day)
  }

  func 첫칸_날_계산(달_첫날: NSDate) -> NSTimeInterval {
    var 날 = 달_첫날
    while true {
      let 분해 = 달력.components(날_플래그 | .CalendarUnitWeekday, fromDate: 날)
      if 분해.weekday == 1 {
        return 달력.dateFromComponents(분해)!.timeIntervalSinceReferenceDate
      }
      날 = 날.dateByAddingTimeInterval(-60 * 60 * 24)
    }
  }

  func 날이_속한_달(날: NSDate) -> Int {
    return 달력.components(.CalendarUnitMonth, fromDate: 날).month
  }

  func 오늘_계산() -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그, fromDate: NSDate())
    return 달력.dateFromComponents(분해)!.timeIntervalSinceReferenceDate
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
        app.tasks.달성율_계산()
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
        기록.task == nil ? 문자열 :
                          countElements(문자열) == 2 ? 문자열 + "\n" + 기록.task!.icon :
                                                      문자열 + 기록.task!.icon
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

  func 앞에_비는_날수(첫날: NSDate) -> Int {
    let 분해 = 달력.components(.CalendarUnitWeekday, fromDate: 첫날)
    return 분해.weekday - 1
  }

  func 달_날수(날: NSDate) -> Int {
    let 날_범위 = 달력.rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth, forDate: 날)
    return 날_범위.length
  }

  func multipleOf(x: Int, _ y: Int) -> Int {
    return (x + y - 1) / y * y
  }

  func 문자열에서(문자열: String) -> NSTimeInterval {
    let 오늘 = NSDate()
    let 구성요소 = 달력.components(날_플래그, fromDate: 오늘)
    구성요소.day = 문자열.toInt()!
    return 달력.dateFromComponents(구성요소)!.timeIntervalSinceReferenceDate
  }

  func 전_달_보여줘() {
    let 분해 = 달력.components(날_플래그, fromDate: 달_첫날)
    if 분해.month > 1 {
      분해.month--
    } else {
      분해.month = 12
      분해.year--
    }
    달_첫날_변경(분해)
  }

  func 다음_달_보여줘() {
    let 분해 = 달력.components(날_플래그, fromDate: 달_첫날)
    if 분해.month < 12 {
      분해.month++
    } else {
      분해.month = 1
      분해.year++
    }
    달_첫날_변경(분해)
  }

  func 달_첫날_변경(분해: NSDateComponents) {
    달_첫날 = 달력.dateFromComponents(분해)!
    (첫칸_날, 보여주는_달) = 달_변화에_따라(달_첫날)
    collectionView!.reloadData()
  }

  func 달_변화에_따라(달_첫날: NSDate) -> (NSTimeInterval, Int) {
    return (첫칸_날_계산(달_첫날), 날이_속한_달(달_첫날))
  }

  func 보여주는_달_이름() -> String {
    let comps = 달력.components(.CalendarUnitMonth, fromDate: 달_첫날)
    let str = 달력.monthSymbols[comps.month - 1] as String
    return str
  }

  func 오늘에서_달의_첫날() -> NSDate {
    let 오늘 = NSDate()
    let 분해 = 달력.components(날_플래그, fromDate: 오늘)
    분해.day = 1
    return 달력.dateFromComponents(분해)!
  }
}
