//
//  TaskFormController.swift
//  JaCal
//
//  Created by Jake Song on 8/28/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

struct TaskTempl {
  var icon: String
  var title: String

  init(_ icon: String, _ title: String) {
    self.icon = icon
    self.title = title
  }
}

class TaskFormController: UIViewController {
  @IBOutlet weak var icon: UILabel!
  @IBOutlet weak var desc: UITextField!
  let templates: [TaskTempl] = [
    TaskTempl("🚶", "걷기"),
    TaskTempl("🏃", "달리기"),
    TaskTempl("🚲", "자전거 타기"),
    TaskTempl("⭐️", "뭐라도 하기"),
    TaskTempl("💃", "춤추기"),
    TaskTempl("💅", "손톱 정리하기"),
    TaskTempl("💊", "약 먹기"),
    TaskTempl("📝", "공부하기"),
    TaskTempl("🎸", "밴드 연습"),
    TaskTempl("🏈", "운동하기"),
    TaskTempl("💪", "운동하기"),
    TaskTempl("💑", "데이트 하기"),
    TaskTempl("💋", "아잉~"),
    TaskTempl("🐕", "개 산책 시키기"),
    TaskTempl("🐈", "고양이 목욕 시키기"),
    TaskTempl("🌵", "화분 물주기"),
    TaskTempl("🛀", "목욕하기"),
    TaskTempl("🚿", "샤워하기"),
    TaskTempl("🚽", "똥싸기"),
    TaskTempl("🙆", "요가하기"),
    TaskTempl("🏀", "농구하기"),
    TaskTempl("⚽️", "축구하기"),
    TaskTempl("⚾️", "야구하기"),
    TaskTempl("🎾", "테니스하기"),
    TaskTempl("🎱", "당구하기"),
    TaskTempl("🏉", "운동하기"),
    TaskTempl("🎳", "볼링하기"),
    TaskTempl("⛳️", "골프치기"),
    TaskTempl("🚴", "싸이클 타기"),
    TaskTempl("🎣", "낚시 하기"),
    TaskTempl("🏂", "스키 타기"),
    TaskTempl("🏊", "수영 하기"),
    TaskTempl("🏄", "써핑 하기"),
    TaskTempl("⛵️", "요트 타기"),
    TaskTempl("🍺", "술 먹기"),
    TaskTempl("🍷", "술 먹기"),
    TaskTempl("🏥", "병원 가기"),
    TaskTempl("💈", "미장원 가기"),
    TaskTempl("💇", "미장원 가기"),
    TaskTempl("🉐", "뭔가 얻음"),
    TaskTempl("✅", "뭔가 함"),
    TaskTempl("❌", "뭔가 함"),
    TaskTempl("⭕️", "뭔가 함"),
    TaskTempl("🔴", "뭔가 함"),
    TaskTempl("🔵", "뭐라도 하자"),
    TaskTempl("✔️", "뭐라도 하자"),
    TaskTempl("💯", "아주 잘함"),
    TaskTempl("🔪", "요리하기"),
    TaskTempl("🍛", "요리하기"),
    TaskTempl("🍲", "요리하기"),
    TaskTempl("⛺️", "캠핑가기"),
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

  func collectionView(cv: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    return templates.count
  }
  
  func collectionView(cv: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
    let index = indexPath.indexAtPosition(1)
    let cell = cv.dequeueReusableCellWithReuseIdentifier("icon", forIndexPath:indexPath) as IconCell
    cell.label.text = templates[index].icon
    return cell
  }

  func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
    let index = indexPath.row
    icon.text = templates[index].icon
    desc.placeholder = templates[index].title
  }
}
