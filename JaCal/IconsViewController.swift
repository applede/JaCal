//
//  IconsViewController.swift
//  JaCal
//
//  Created by Jake Song on 9/5/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

//let reuseIdentifier = "Cell"

class IconsViewController: UICollectionViewController {
  let templates: [TaskTempl] = [
    TaskTempl("🚶", "걷기"),
    TaskTempl("🏃", "달리기"),
    TaskTempl("🚲", "자전거 타기"),
    TaskTempl("🗻", "등산하기"),
    TaskTempl("⭐️", "뭐라도 하기"),
    TaskTempl("💃", "춤추기"),
    TaskTempl("💅", "손톱 정리하기"),
    TaskTempl("💊", "약 먹기"),
    TaskTempl("📖", "책 읽기"),
    TaskTempl("📚", "책 읽기"),
    TaskTempl("📝", "공부하기"),
    TaskTempl("💌", "편지 쓰기"),
    TaskTempl("📷", "사진 찍기"),
    TaskTempl("🎸", "밴드 연습"),
    TaskTempl("🏈", "운동하기"),
    TaskTempl("💪", "팔굽혀펴기"),
    TaskTempl("💑", "데이트 하기"),
    TaskTempl("💋", "아잉~"),
    TaskTempl("🐕", "개 산책 시키기"),
    TaskTempl("🐈", "고양이 목욕 시키기"),
    TaskTempl("🌵", "화분 물주기"),
    TaskTempl("🛀", "목욕하기"),
    TaskTempl("🚿", "샤워하기"),
    TaskTempl("🚽", "화장실 가기"),
    TaskTempl("💩", "똥싸기"),
    TaskTempl("🚴", "자전거 타기"),
    TaskTempl("🚵", "산악 자전거 타기"),
    TaskTempl("🙆", "요가하기"),
    TaskTempl("🏀", "농구하기"),
    TaskTempl("⚽️", "축구하기"),
    TaskTempl("⚾️", "야구하기"),
    TaskTempl("🎾", "테니스하기"),
    TaskTempl("🎱", "당구하기"),
    TaskTempl("🏉", "운동하기"),
    TaskTempl("🎳", "볼링하기"),
    TaskTempl("⛳️", "골프치기"),
    TaskTempl("🎣", "낚시 하기"),
    TaskTempl("🎿", "스키 타기"),
    TaskTempl("🏂", "스키 타기"),
    TaskTempl("🏊", "수영 하기"),
    TaskTempl("🏄", "써핑 하기"),
    TaskTempl("⛵️", "요트 타기"),
    TaskTempl("🌄", "등산하기"),
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
    TaskTempl("☕", "차 마시기"),
    TaskTempl("⛪", "교회 가기"),
    TaskTempl("🎥", "영화 보기"),
    TaskTempl("🎤", "노래방 가기"),
    TaskTempl("🎮", "게임 하기"),
    TaskTempl("🏥", "병원 가기"),
    TaskTempl("🏫", "학교 가기"),
    TaskTempl("🐎", ""),
    TaskTempl("🐼", ""),
    TaskTempl("👠", ""),
    TaskTempl("👙", ""),
    TaskTempl("👗", ""),
    TaskTempl("💄", ""),
    TaskTempl("💔", ""),
    TaskTempl("💤", ""),
    TaskTempl("💖", ""),
    TaskTempl("💘", ""),
    TaskTempl("💡", ""),
    TaskTempl("💵", ""),
    TaskTempl("☎", "전화하기"),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Register cell classes
    //        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

  // MARK: UICollectionViewDataSource

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //#warning Incomplete method implementation -- Return the number of sections
    return 1
  }


  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return templates.count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("아이콘", forIndexPath: indexPath) as IconCell

    // Configure the cell
    cell.label.text = templates[indexPath.row].icon

    return cell
  }

  // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView!, shouldHighlightItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

//  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//  }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView!, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, canPerformAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, performAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) {
    
    }
    */

  func 아이콘() -> String {
    let 선택 = collectionView!.indexPathsForSelectedItems() as [NSIndexPath]
    if 선택.count > 0 {
      return templates[선택[0].row].icon
    }
    return "❌"
  }

  func 설명() -> String {
    let 선택 = collectionView!.indexPathsForSelectedItems() as [NSIndexPath]
    if 선택.count > 0 {
      return templates[선택[0].row].title
    }
    return "뭔가함"
  }
}
