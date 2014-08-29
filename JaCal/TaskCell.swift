//
//  TaskCell.swift
//  JaCal
//
//  Created by Jake Song on 8/29/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
  @IBOutlet weak var icon: UILabel!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var progress: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
