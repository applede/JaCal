//
//  TasksViewController.swift
//  JaCal
//
//  Created by Jake Song on 10/9/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var collectionView: UICollectionView!
  weak var viewMode: UIButton!
  weak var editMode: UIButton!

  var gridMode = false
  var tasks: [Task] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    collectionView.allowsSelection = true
    app.tasksViewController = self
    tasks = app.tasks()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TaskIconCell {
      cell.backgroundColor = UIColor.blueColor()
    }
  }

  func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TaskIconCell {
      cell.backgroundColor = UIColor.clearColor()
    }
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("icon", forIndexPath: indexPath) as TaskIconCell
    let task = tasks[indexPath.row]
    cell.icon.text = task.icon
    return cell
  }

  override func viewWillAppear(animated: Bool) {
    if let indexPath = tableView.indexPathForSelectedRow() {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
  }
  
  func refreshCount() {
    if let index = tableView.indexPathForSelectedRow() {
      let cell = tableView.cellForRowAtIndexPath(index) as TaskCell
      cell.progress.text = dayWeekMonthCount(tasks[index.row])
    }
  }

  func selectedTask() -> Task? {
    if let index = tableView.indexPathForSelectedRow() {
      return tasks[index.row]
    }
    return nil
  }

  func addTask(task: Task) {
    task.order = Int16(tasks.count)
    tasks.append(task)
    refresh()
  }

  func refresh() {
    if gridMode {
      collectionView.reloadData()
    } else {
      tableView.reloadData()
    }
  }

  func switchView(sender: UIButton) {
    if tableView.editing {
      edit(editMode)
    }
    if gridMode {
      toListView()
    } else {
      gridMode = true
      sender.setImage(UIImage(named: "List"), forState: .Normal)
      view.bringSubviewToFront(collectionView)
    }
  }

  func toListView() {
    gridMode = false
    viewMode.setImage(UIImage(named: "Grid"), forState: .Normal)
    view.bringSubviewToFront(tableView)
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count + 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
      cell.progress.text = dayWeekMonthCount(tasks[index])
      return cell
    }
  }

  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if indexPath.row < tasks.count {
      return true
    } else {
      return false
    }
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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

  func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
    if proposedDestinationIndexPath.row >= tasks.count {
      return NSIndexPath(forRow: tasks.count - 1, inSection: proposedDestinationIndexPath.section)
    }
    return proposedDestinationIndexPath
  }

  func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    let t = tasks[fromIndexPath.row]
    tasks.removeAtIndex(fromIndexPath.row)
    tasks.insert(t, atIndex: toIndexPath.row)
  }

  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if tableView.editing {
      performSegueWithIdentifier("addTask", sender: self)
    }
  }

  func dayWeekMonthCount(task: Task) -> String {
    var 주 = 0
    var 월 = 0
    var 년 = 0
    let 오늘 = NSDate()
    let 주의_첫날 = firstDayOfWeek(오늘)
    let 월의_첫날 = firstDayOfMonth(오늘)
    let 년의_첫날 = firstDayOfYear(오늘)
    for 한적 in task.dones {
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

  func firstDayOfWeek(날: NSDate) -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그 | .CalendarUnitWeekday, fromDate: 날)
    let 시간_없앤_날 = 달력.dateFromComponents(분해)!
    return 시간_없앤_날.dateByAddingTimeInterval(-60 * 60 * 24 * Double(분해.weekday - 1))!.timeIntervalSinceReferenceDate
  }

  func firstDayOfMonth(날: NSDate) -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그, fromDate: 날)
    분해.day = 1
    return 달력.dateFromComponents(분해)!.timeIntervalSinceReferenceDate
  }

  func firstDayOfYear(날: NSDate) -> NSTimeInterval {
    let 분해 = 달력.components(날_플래그, fromDate: 날)
    분해.day = 1
    분해.month = 1
    return 달력.dateFromComponents(분해)!.timeIntervalSinceReferenceDate
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "addTask" {
      let controller = segue.destinationViewController as TaskFormController
      if tableView.editing {
        controller.title = "목표 수정"
        controller.task = selectedTask()
      } else {
        controller.title = "목표 설정"
        controller.task = nil
      }
    }
  }

  @IBAction func edit(sender: UIButton) {
    if tableView.editing {
      tableView.setEditing(false, animated: true)
      sender.setTitle("수정", forState: .Normal)
      saveOrder()
    } else {
      tableView.setEditing(true, animated: true)
      sender.setTitle("완료", forState: .Normal)
      if gridMode {
        toListView()
      }
    }
  }

  func saveOrder() {
    var order = 0
    for t in tasks {
      t.order = Int16(order++)
    }
    app.saveContext()
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tasks.count
  }
}
