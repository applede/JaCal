//
//  HalfSegue.swift
//  JaCal
//
//  Created by Jake Song on 9/5/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import UIKit

@objc(HalfSegue) class HalfSegue: UIStoryboardSegue {
  override func perform() {
    let src = sourceViewController as UIViewController
    let dst = destinationViewController as UIViewController
    let 덮개 = UIView(frame: src.view.bounds)

    덮개.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
    dst.view.frame = CGRectMake(0, src.view.frame.height, dst.view.frame.size.width, dst.view.frame.size.height)

    src.addChildViewController(dst)
    src.view.addSubview(덮개)
    덮개.addSubview(dst.view)
    dst.didMoveToParentViewController(src)

    UIView.animateWithDuration(0.5) {
      덮개.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
      dst.view.frame = CGRectMake(0, 260, dst.view.frame.size.width, dst.view.frame.size.height)
    }
  }
}

func 반팝업_없애(콘트롤러: UIViewController) {
  let 덮개 = 콘트롤러.view.superview!
  let 뷰 = 콘트롤러.view
  UIView.animateWithDuration(0.5, animations: {
    덮개.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
    뷰.frame = CGRectMake(0, 덮개.frame.height, 뷰.frame.width, 뷰.frame.height)
    }, completion: { 끝 in
      덮개.removeFromSuperview()
      뷰.removeFromSuperview()
      콘트롤러.removeFromParentViewController()
  })
}
