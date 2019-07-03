//
//  CircularProgressBar.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {

  var isRounded = true {
    didSet {
      layer.cornerRadius = isRounded ? bounds.height/2 : 0
      gradientLayer.cornerRadius = isRounded ? bounds.height/2 : 0
    }
  }

  var trackWidth: CGFloat = 8 {
    didSet {
      track.lineWidth = trackWidth
      progressBar.lineWidth = trackWidth
    }
  }

  var borderWidth: CGFloat = 2 {
    didSet {
      border.lineWidth = borderWidth
    }
  }

  var borderPadding: CGFloat = 4

  private var progress: CGFloat = 0

  var colors = [UIColor.pastelBlue.cgColor, UIColor.pastelGreen.cgColor]

  private let gradientLayer = CAGradientLayer()
  private let border = CAShapeLayer()
  private let track = CAShapeLayer()
  private let progressBar = CAShapeLayer()

  override func draw(_ rect: CGRect) {

    //calculate the path & properties
    track.frame = rect
    let quater = CGFloat.pi/2
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: (rect.width/2) - (trackWidth + borderWidth + borderPadding), startAngle: -quater, endAngle: quater * 3, clockwise: true)
    circlePath.lineWidth = trackWidth
    track.path = circlePath.cgPath
    track.strokeColor = UIColor.groupTableViewBackground.cgColor
    track.fillColor = UIColor.clear.cgColor
    track.lineWidth = trackWidth

    //setup the progress bar shape
    progressBar.frame = rect
    progressBar.lineCap = .round
    progressBar.path = circlePath.cgPath
    progressBar.strokeStart = 0
    progressBar.strokeEnd = progress
    progressBar.lineWidth = trackWidth
    progressBar.strokeColor = UIColor.black.cgColor
    progressBar.fillColor = UIColor.clear.cgColor

    //create gradient and mask it with progress bar
    gradientLayer.frame = rect
    gradientLayer.colors = colors
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    gradientLayer.position = CGPoint(x: 0, y: 0)
    gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
    gradientLayer.mask = progressBar

    //create border
    border.frame = rect
    let borderPath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: (rect.width/2) - (borderWidth), startAngle: -quater, endAngle: quater * 3, clockwise: true)
    border.lineWidth = borderWidth
    border.path = borderPath.cgPath
    border.strokeColor = UIColor.black.cgColor
    border.fillColor = UIColor.clear.cgColor

    //add sublayers
    if track.superlayer == nil {
      layer.addSublayer(border)
      layer.addSublayer(track)
      layer.addSublayer(gradientLayer)
    }
  }

  func setProgress(_ progress: Float, animated: Bool = true) {
    self.progress = CGFloat(progress)
    progressBar.removeAllAnimations()
    let anim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
    anim.fromValue = progressBar.strokeEnd
    anim.toValue = CGFloat(progress)
    anim.duration = animated ? 0.4 : 0
    anim.fillMode = .forwards
    progressBar.strokeEnd = CGFloat(progress)
    progressBar.add(anim, forKey: "Stroke")
  }

}
