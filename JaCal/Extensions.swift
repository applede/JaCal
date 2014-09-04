//
//  Extensions.swift
//  JaCal
//
//  Created by Jake Song on 9/4/14.
//  Copyright (c) 2014 Jake Song. All rights reserved.
//

import Foundation

extension Array {
  func 각각의(블럭: (T) -> ()) -> Array {
    for 아이템 in self {
      블럭(아이템)
    }
    return self
  }
}