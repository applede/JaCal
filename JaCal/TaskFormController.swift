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
  @IBOutlet weak var 시작일: UIButton!
  @IBOutlet weak var 종료일: UIButton!
  @IBOutlet weak var 기간: UIButton!
  @IBOutlet weak var 주기: UIButton!
  @IBOutlet weak var 횟수: UIButton!

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
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if segue.identifier == "아이콘" {
      (segue.destinationViewController as IconsViewController).parent = self
    }
//    println(segue)
  }

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
    let ㄱ = 기간.currentTitle?.toInt()
    let ㅈ = 주기.currentTitle?.toInt()
    let ㅎ = 횟수.currentTitle?.toInt()
    app.addTask(icon.currentTitle!, title: title, duration: ㄱ!, freq: ㅈ!, count: ㅎ!)
  }

  @IBAction func 목표_설정으로(세그: UIStoryboardSegue) {
    if let 아이콘스 = 세그.sourceViewController as? IconsViewController {
      println(아이콘스)
      반팝업_없애()
      아이콘스.view.removeFromSuperview()
      아이콘스.dismissViewControllerAnimated(true, completion: nil)
    }
  }
}
