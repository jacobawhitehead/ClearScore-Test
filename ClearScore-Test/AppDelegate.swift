//
//  AppDelegate.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  lazy var networkService: NetworkServiceInterface = {
    return NetworkService()
  }()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let creditViewController = CreditScoreViewController.instantiate()
    creditViewController.viewModel = CreditScoreViewModel(api: CreditScoreAPI(service: networkService))

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = creditViewController
    window?.makeKeyAndVisible()

    return true
  }

}

