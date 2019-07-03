//
//  CreditScoreViewModel.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

class CreditScoreViewModel: CreditScoreViewModelInterface {

  private weak var view: CreditScoreViewInterface?

  private let creditScoreAPI: CreditScoreAPIInterface

  init(api: CreditScoreAPIInterface) {
    self.creditScoreAPI = api
  }

  //MARK: CreditScoreViewModelInterface
  func onViewDidLoad(_ view: CreditScoreViewInterface) {
    self.view = view
    loadCreditScore()
  }

  func onRetryTapped() {
    view?.creditScore = nil
    view?.hideError()
    loadCreditScore()
  }

  //MARK: Private functions
  private func loadCreditScore() {
    view?.showLoading(true)
    creditScoreAPI.getCurrentCreditScore { [weak self] (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let creditScore):
          self?.view?.creditScore = CreditScoreRepresentable(score: creditScore)
        case .failure:
          self?.view?.showError("Sorry, something went wrong")
        }

        self?.view?.showLoading(false)
      }
    }
  }

}

//MARK: CreditScoreRepresentable Conveniance Init
private extension CreditScoreRepresentable {

  init(score: CreditScore) {
    self.currentScore = String(score.creditReportInfo.score)
    self.totalPossibleScore = "Out of \(String(score.creditReportInfo.maxScoreValue))"
    self.progress = Float(score.creditReportInfo.score)/Float(score.creditReportInfo.maxScoreValue)
  }

}
