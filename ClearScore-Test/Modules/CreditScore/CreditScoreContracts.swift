//
//  CreditScoreContracts.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

protocol CreditScoreViewInterface: class {
  var creditScore: CreditScoreRepresentable? { get set }
  func showLoading(_ show: Bool)
  func showError(_ message: String)
  func hideError()
}

protocol CreditScoreViewModelInterface {
  func onViewDidLoad(_ view: CreditScoreViewInterface)
  func onRetryTapped()
}

struct CreditScoreRepresentable {
  let currentScore: String
  let totalPossibleScore: String
  let progress: Float
}
