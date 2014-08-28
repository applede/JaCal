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
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    let context = delegate.managedObjectContext!
    let fetchRequest = NSFetchRequest()
    fetchRequest.entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)
    var error: NSError?
    let fetchedObjects = context.executeFetchRequest(fetchRequest, error: &error)
    for task in fetchedObjects as [Task] {
      print(task.title)
      print(" ")
      for done in task.dones {
        let taskDone = done as TaskDone
        print(NSDate(timeIntervalSinceReferenceDate: taskDone.date))
      }
      tasks += [task]
      println()
    }
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
    let cell = tableView.dequeueReusableCellWithIdentifier(index == tasks.count ? "taskAdd" : "task", forIndexPath: indexPath) as UITableViewCell
    cell.selectedBackgroundView = UIView()
    cell.selectedBackgroundView.backgroundColor = tableView.tintColor
    if index == tasks.count {
//      cell.imageView.image = cell.imageView.image.imageWithRenderingMode(.AlwaysTemplate)
//      cell.imageView.tintColor = UIColor.blueColor()
    } else {
      cell.textLabel.text = "Hello"
    }
    return cell
  }

  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
  // Return NO if you do not want the specified item to be editable.
  return true
  }
  */
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }    
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
  // Return NO if you do not want the item to be re-orderable.
  return true
  }
  */
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
}
