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

  override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return tasks.count + 1
  }
  
  override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
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
      cell.progress.text = "0%"
      return cell
    }
  }

  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
  // Return NO if you do not want the specified item to be editable.
  return true
  }
  */
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
    if editingStyle == .Delete {
      // Delete the row from the data source
      app.managedObjectContext?.deleteObject(tasks[indexPath.row])
      app.saveContext()
      tasks.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }    
  }

  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
  
  }

  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
  }

  func addTask(task: Task) {
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
}
