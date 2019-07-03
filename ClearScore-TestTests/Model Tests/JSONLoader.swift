//
//  JSONLoader.swift
//  ClearScore-TestTests
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

class JSONLoader {

  func loadJSON(from file: String) -> Data? {
    guard let path = Bundle(for: type(of: self)).url(forResource: file, withExtension: "json") else {
      return nil
    }

    return try? Data(contentsOf: path )
  }

}

