//
//  TasksViewController.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit
import CoreData

class TasksViewController: UITableViewController {
  var tasks: [Task] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem()
    app.tasks = self
    tasks = app.목표들()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
//  override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//    return 1
//  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count + 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let index = indexPath.row
    if index == tasks.count {
      let cell = tableView.dequeueReusableCellWithIdentifier("taskAdd", forIndexPath: indexPath) as UITableViewCell
      cell.selectedBackgroundView = UIView()
      cell.selectedBackgroundView.backgroundColor = tableView.tintColor
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("task", forIndexPath: indexPath) as TaskCell
      cell.selectedBackgroundView = UIView()
      cell.selectedBackgroundView.backgroundColor = tableView.tintColor
      cell.icon.text = tasks[index].icon
      cell.title.text = tasks[index].title
      cell.progress.text = 달성률(tasks[index])
      return cell
    }
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if indexPath.row < tasks.count {
      return true
    } else {
      return false
    }
  }
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      // Delete the row from the data source
      app.관리된_객체_맥락.deleteObject(tasks[indexPath.row])
      app.saveContext()
      tasks.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }

  override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
    if proposedDestinationIndexPath.row >= tasks.count {
      return NSIndexPath(forRow: tasks.count - 1, inSection: proposedDestinationIndexPath.section)
    }
    return proposedDestinationIndexPath
  }

  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    let t = tasks[fromIndexPath.row]
    tasks.removeAtIndex(fromIndexPath.row)
    tasks.insert(t, atIndex: toIndexPath.row)
  }

  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
  }

  func addTask(task: Task) {
    task.order = Int16(tasks.count)
    tasks.append(task)
    (view as UITableView).reloadData()
  }

  func selectedTask() -> Task? {
    let table = view as UITableView
    if let index = table.indexPathForSelectedRow() {
      return tasks[index.row]
    }
    return nil
  }

  func 달성률_계산() {
    let 테이블 = view as UITableView
    if let 인덱스 = 테이블.indexPathForSelectedRow() {
      let 셀 = 테이블.cellForRowAtIndexPath(인덱스) as TaskCell
      let 목표 = tasks[인덱스.row]
      셀.progress.text = 달성률(목표)
    }
  }

  func 달성률(목표: Task) -> String {
    var 주 = 0
    var 월 = 0
    var 년 = 0
    let 오늘 = NSDate()
    let 주의_첫날 = 주의_첫날_계산(오늘)
    let 월의_첫날 = 월의_첫날_계산(오늘)
    let 년의_첫날 = 년의_첫날_계산(오늘)
    for 한적 in 목표.dones {
      let 기록 = 한적 as TaskDone
      if 기록.date >= 주의_첫날 {
        주++
      }
      if 기록.date >= 월의_첫날 {
        월++
      }
      if 기록.date >= 년의_첫날 {
        년++
      }
    }
    return String(format: "%d/%d/%d", 주, 월, 년)
  }

  func 주의_첫날_계산(날: NSDate) -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그 | .CalendarUnitWeekday, fromDate: 날)
    let 시간_없앤_날 = 달력.dateFromComponents(분해)!
    return 시간_없앤_날.dateByAddingTimeInterval(-60 * 60 * 24 * Double(분해.weekday - 1))!.timeIntervalSinceReferenceDate
  }

  func 월의_첫날_계산(날: NSDate) -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그, fromDate: 날)
    분해.day = 1
    return 달력.dateFromComponents(분해)!.timeIntervalSinceReferenceDate
  }

  func 년의_첫날_계산(날: NSDate) -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그, fromDate: 날)
    분해.day = 1
    분해.month = 1
    return 달력.dateFromComponents(분해)!.timeIntervalSinceReferenceDate
  }

  @IBAction func 편집모드(sender: UIButton) {
    let 테이블 = view as UITableView
    if 테이블.editing {
      테이블.setEditing(false, animated: true)
      sender.setTitle("수정", forState: .Normal)
      순서저장()
    } else {
      테이블.setEditing(true, animated: true)
      sender.setTitle("완료", forState: .Normal)
    }
  }

  func 순서저장() {
    var 순서 = 0
    for t in tasks {
      t.order = Int16(순서++)
    }
    app.saveContext()
  }
}
