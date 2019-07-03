//
//  Storyboarded.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit

protocol Storyboarded {
  static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate() -> Self {
    let fullName = NSStringFromClass(self)
    let className = fullName.components(separatedBy: ".")[1]
    let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
    return storyboard.instantiateViewController(withIdentifier: className) as! Self
  }
}
