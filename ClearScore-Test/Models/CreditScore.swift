//
//  CreditScore.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

struct CreditScore {

  struct Report {
    let score: Int
    let minScoreValue: Int
    let maxScoreValue: Int
  }

  let creditReportInfo: Report

}

extension CreditScore.Report: Codable {}

extension CreditScore: Codable {}
