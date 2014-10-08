//
//  TaskFormController.swift
//  JaCal
//
//  Created by Jake Song on 8/28/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit
import CoreData

struct TaskTempl {
  var icon: String
  var title: String

  init(_ icon: String, _ title: String) {
    self.icon = icon
    self.title = title
  }
}

class TaskFormController: UIViewController {
  @IBOutlet weak var icon: UIButton!
  @IBOutlet weak var desc: UITextField!
  @IBOutlet weak var 화살표: UIButton!
  var 아이콘스: UIViewController?

  var durations: [String] = [
    "오늘부터", "일주 동안", "이주 동안", "삼주 동안", "한달 동안", "두달 동안", "세달 동안", "반년 동안", "일년 동안"
  ]
  var periods: [String] = [
    "총", "매일", "매주", "매달", "매분기", "반년마다", "매년",
  ]
  let maxFreq: [Int] = [ 7, 2, 3, 3, 3, 4, 4, 5, 6 ]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done:")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//  }

  func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
  }

  func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
    return 3
  }

  func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return durations.count
    } else if component == 1 {
      let period = pickerView.selectedRowInComponent(0)
      return maxFreq[period]
    } else {
      return 100
    }
  }

  func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
    if component == 0 {
      return durations[row]
    } else if component == 1 {
      return periods[row]
    } else {
      return "\(row+1)회"
    }
  }

  func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      pickerView.reloadComponent(1)
    }
  }

  @IBAction func done(sender: AnyObject) {
    navigationController?.popViewControllerAnimated(true)
    var title = desc.text
    if title == "" {
      title = desc.placeholder
    }
    app.addTask(icon.currentTitle!, title: title)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "아이콘" || segue.identifier == "아이콘2" {
      아이콘스 = segue.destinationViewController as? UIViewController
      화살표.setTitle("▽", forState: .Normal)
    }
  }

  @IBAction func 목표_설정으로(세그: UIStoryboardSegue) {
    if let 아이콘스 = 세그.sourceViewController as? IconsViewController {
      icon.setTitle(아이콘스.아이콘(), forState: .Normal)
      desc.placeholder = 아이콘스.설명()
      반팝업_없애(아이콘스)
      화살표.setTitle("▷", forState: .Normal)
    }
  }

  func 반팝업_없애기() {
    반팝업_없애(아이콘스!)
    화살표.setTitle("▷", forState: .Normal)
  }
}
