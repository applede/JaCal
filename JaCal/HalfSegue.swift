//
//  HalfSegue.swift
//  JaCal
//
//  Created by Jake Song on 9/5/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

var 덮개: UIView! = nil

@objc(HalfSegue) class HalfSegue: UIStoryboardSegue {
  override func perform() {
    let src = sourceViewController as UIViewController
    let dst = destinationViewController as UIViewController
    덮개 = UIView(frame: CGRectMake(0, src.view.frame.height, src.view.frame.width, src.view.frame.height))

    덮개.backgroundColor = UIColor.blackColor()
    덮개.alpha = 0.0
    dst.view.frame = CGRectMake(0, src.view.frame.height, dst.view.frame.size.width, dst.view.frame.size.height)

    src.addChildViewController(dst)
    src.view.addSubview(덮개)
    src.view.addSubview(dst.view)
    dst.didMoveToParentViewController(src)

    UIView.animateWithDuration(0.5) {
      덮개.frame = src.view.frame
      덮개.alpha = 0.3
      dst.view.frame = CGRectMake(0, 260, dst.view.frame.size.width, dst.view.frame.size.height)
    }
  }
}

func 반팝업_없애() {
  UIView.animateWithDuration(0.5, animations: {
    덮개.frame = CGRectMake(0, 480, 덮개.frame.width, 덮개.frame.height)
    덮개.alpha = 0.0
    }, completion: { 끝 in
      덮개.removeFromSuperview()
  })
}