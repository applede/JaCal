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
    self.title = thisMonth
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    switch segue.identifier {
    case nil:
      return
    case "calendar":
      calendar = segue.destinationViewController as CalendarViewController
    case "tasks":
      tasks = segue.destinationViewController as TasksViewController
    default:
      return
    }
  }
}

