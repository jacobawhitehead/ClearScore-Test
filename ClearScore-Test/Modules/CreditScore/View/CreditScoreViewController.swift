//
//  CreditScoreViewController.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit

class CreditScoreViewController: UIViewController, CreditScoreViewInterface {

  var creditScore: CreditScoreRepresentable? {
    didSet {
      updateScore()
    }
  }

  //Error views
  @IBOutlet weak var errorImage: UIImageView!
  @IBOutlet weak var errorStackView: UIStackView!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var retryButton: UIButton!

  //Credit related views
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var progressBar: CircularProgressBar!
  @IBOutlet weak var creditDescriptionLabel: UILabel!
  @IBOutlet weak var creditValueLabel: UILabel!
  @IBOutlet weak var creditOutOfLabel: UILabel!

  var viewModel: CreditScoreViewModelInterface?

  override func viewDidLoad() {
    super.viewDidLoad()
    stackView.alpha = 0
    viewModel?.onViewDidLoad(self)
  }

  func showLoading(_ show: Bool) {
    if show {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
  }

  func showError(_ message: String) {
    errorStackView.alpha = 1
    errorImage.alpha = 1
    errorLabel.text = message
  }

  func hideError() {
    errorStackView.alpha = 0
    errorImage.alpha = 0
  }

  private func updateScore() {
    if let score = creditScore {
      creditDescriptionLabel.text = "Your credit score is"
      creditValueLabel.text = score.currentScore
      creditOutOfLabel.text = score.totalPossibleScore
      progressBar.setProgress(score.progress, animated: true)
      animateInStack()
    } else {
      creditDescriptionLabel.text = nil
      creditValueLabel.text = nil
      creditOutOfLabel.text = nil
      progressBar.setProgress(0, animated: true)
    }
  }

  private func animateInStack() {
    stackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

    UIView.animate(withDuration: 0.4) {
      self.stackView.transform = .identity
      self.stackView.alpha = 1
    }
  }

  @IBAction func retryTapped(_ sender: Any) {
    viewModel?.onRetryTapped()
  }

}

extension CreditScoreViewController: Storyboarded {}
