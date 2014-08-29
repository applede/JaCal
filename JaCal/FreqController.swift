//
//  FreqController.swift
//  JaCal
//
//  Created by Jake Song on 8/28/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

class FreqController: UIViewController {
  var durations: [String] = [
    "일주일간", "2주일간", "3주동안", "한달동안", "두달동안", "세달간", "반년동안", "일년동안"
  ]
  var periods: [String] = [
    "매일", "매주", "매달", "매분기", "반년마다", "매년",
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */

  func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
    return 3
  }

  func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return durations.count
    } else if component == 1 {
      return periods.count
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
}
