//
//  NetworkService.swift
//  ClearScore-Test
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
  case invalidResponse, invalidRequest, decodingError, general(Error?)
}

protocol NetworkServiceInterface {
  func handleRequest<T: Decodable>(_ request: URLRequest, decodingTo decodable: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceInterface {

  private let session = URLSession.shared

  private lazy var decoder: JSONDecoder = {
    return JSONDecoder()
  }()

  func handleRequest<T: Decodable>(_ request: URLRequest, decodingTo decodable: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    session.dataTask(with: request) { [weak self] (data, response, error) in
      guard let self = self else { return }
      guard error == nil else {
        completion(.failure(NetworkError.general(error)))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
        completion(.failure(NetworkError.invalidResponse))
        return
      }

      do {
        let models = try self.decoder.decode(T.self, from: data)
        completion(.success(models))
      } catch {
        completion(.failure(NetworkError.decodingError))
      }
    }.resume()
  }

}


