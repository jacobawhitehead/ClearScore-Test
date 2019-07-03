//
//  CreditScoreTests.swift
//  CreditScoreTests
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import XCTest
@testable import ClearScore_Test

class CreditScoreTests: XCTestCase {

  let loader = JSONLoader()

  let decoder = JSONDecoder()

  func testCreditScoreParsing() {
    guard let data = loader.loadJSON(from: "credit") else {
      XCTFail("Could not load JSON for credit score test")
      return
    }

    guard let creditScore = try? decoder.decode(CreditScore.self, from: data) else {
      XCTFail("Could not decode Credit Score")
      return
    }

    XCTAssert(creditScore.creditReportInfo.score == 514, "Should have parsed correct score")
    XCTAssert(creditScore.creditReportInfo.maxScoreValue == 700, "Should have parsed correct max")
    XCTAssert(creditScore.creditReportInfo.minScoreValue == 0, "Should have parsed correct min")
  }

}
