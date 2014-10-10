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
  @IBOutlet weak var viewMode: UIButton!
  @IBOutlet weak var editMode: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if segue.identifier == "calendar" {
      calendar = segue.destinationViewController as CalendarViewController
      title = calendar.보여주는_달_이름()
    } else if segue.identifier == "tasks" {
      tasks = segue.destinationViewController as TasksViewController
      tasks.viewMode = viewMode
      tasks.editMode = editMode
    }
  }

  @IBAction func 전_달(sender: UIBarButtonItem) {
    calendar.전_달_보여줘()
    title = calendar.보여주는_달_이름()
  }

  @IBAction func 다음_달(sender: UIBarButtonItem) {
    calendar.다음_달_보여줘()
    title = calendar.보여주는_달_이름()
  }

  @IBAction func switchView(sender: UIButton) {
    tasks.switchView(sender)
  }

  @IBAction func editTasks(sender: UIButton) {
    tasks.edit(sender)
  }
}
