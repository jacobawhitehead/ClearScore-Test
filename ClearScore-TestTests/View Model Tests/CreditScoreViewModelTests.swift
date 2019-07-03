//
//  CreditScoreViewModelTests.swift
//  ClearScore-TestTests
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import XCTest
@testable import ClearScore_Test

class CreditScoreViewModelTests: XCTestCase {

  let mockAPI = MockCreditScoreAPI()
  let mockView = MockCreditScoreView()

  func testLoadData() {
    mockAPI.shouldFail = false
    let viewModel = CreditScoreViewModel(api: mockAPI)

    XCTAssert(mockView.creditScore == nil, "Should be empty as first")

    viewModel.onViewDidLoad(mockView)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssert(self.mockView.showingError == false, "Should not be showing an error")
      XCTAssert(self.mockView.isLoading == false, "Should no longer be loading")
      XCTAssert(self.mockView.creditScore != nil, "Should have a credit score")
      XCTAssert(self.mockView.creditScore!.currentScore == "200", "Should have parsed correct score")
      XCTAssert(self.mockView.creditScore!.progress == 0.5, "Should have parsed correct progress")
      XCTAssert(self.mockView.creditScore!.totalPossibleScore == "Out of 400", "Should have parsed correct score")
    }
  }

  func testLoadDataFail() {
    mockAPI.shouldFail = true
    let viewModel = CreditScoreViewModel(api: mockAPI)

    XCTAssert(mockView.creditScore == nil, "Should be empty as first")

    viewModel.onViewDidLoad(mockView)

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      XCTAssert(self.mockView.showingError == true, "Should be showing an error")
      XCTAssert(self.mockView.isLoading == false, "Should no longer be loading")
      XCTAssert(self.mockView.creditScore == nil, "Should have no credit score")
    }
  }

  func testRetry() {
    mockAPI.shouldFail = true
    let viewModel = CreditScoreViewModel(api: mockAPI)

    XCTAssert(mockView.creditScore == nil, "Should be empty as first")

    viewModel.onViewDidLoad(mockView)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssert(self.mockView.showingError == true, "Should be showing an error")
      XCTAssert(self.mockView.isLoading == false, "Should no longer be loading")
      XCTAssert(self.mockView.creditScore == nil, "Should have no credit score")

      self.mockAPI.shouldFail = false
      viewModel.onRetryTapped()

      DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        XCTAssert(self.mockView.showingError == false, "Should not be showing an error")
        XCTAssert(self.mockView.isLoading == false, "Should no longer be loading")
        XCTAssert(self.mockView.creditScore != nil, "Should have a credit score")
      })
    }
  }

}

class MockCreditScoreAPI: CreditScoreAPIInterface {

  var shouldFail = false

  func getCurrentCreditScore(_ completion: @escaping (Result<CreditScore, Error>) -> Void) {
    if shouldFail {
      completion(.success(CreditScore(creditReportInfo: CreditScore.Report(score: 200, minScoreValue: 0, maxScoreValue: 400))))
    } else {
      completion(.failure(MockError.general))
    }
  }

}

class MockCreditScoreView: CreditScoreViewInterface {

  var showingError = false

  var isLoading = false

  var creditScore: CreditScoreRepresentable?

  func showLoading(_ show: Bool) {
    isLoading = show
  }

  func showError(_ message: String) {
    showingError = true
  }

  func hideError() {
    showingError = false
  }

}

enum MockError: Error {
  case general
}
