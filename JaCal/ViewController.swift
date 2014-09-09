//
//  ViewController.swift
//  JaCal
//
//  Created by Jake Song on 8/27/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var calendar: CalendarViewController!
  var tasks: TasksViewController!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = app.currentMonth
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    switch segue.identifier {
//    case nil:
//      return
    case "calendar":
      calendar = segue.destinationViewController as CalendarViewController
      title = calendar.보여주는_달_이름()
    case "tasks":
      tasks = segue.destinationViewController as TasksViewController
    default:
      return
    }
  }

  @IBAction func 전_달(sender: UIBarButtonItem) {
    calendar.전_달_보여줘()
  }

  @IBAction func 다음_달(sender: UIBarButtonItem) {
    calendar.다음_달_보여줘()
  }
}

