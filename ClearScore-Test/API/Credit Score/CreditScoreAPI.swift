//
//  CreditScoreAPI.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

protocol CreditScoreAPIInterface {
  func getCurrentCreditScore(_ completion: @escaping (Result<CreditScore, Error>) -> Void)
}

class CreditScoreAPI: CreditScoreAPIInterface {

  private let service: NetworkServiceInterface

  init(service: NetworkServiceInterface) {
    self.service = service
  }

  func getCurrentCreditScore(_ completion: @escaping (Result<CreditScore, Error>) -> Void) {
    guard let url = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values") else {
      completion(.failure(NetworkError.invalidRequest))
      return
    }

    service.handleRequest(URLRequest(url: url), decodingTo: CreditScore.self, completion: completion)
  }

}
