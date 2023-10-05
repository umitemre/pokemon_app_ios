//
//  NetworkLayer.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import Alamofire

class NetworkLayer {
    private var url: String?
    
    static let shared: NetworkLayer = NetworkLayer()

    private init() {}
    
    func url(_ url: String) -> NetworkLayer {
        self.url = url
        return self
    }

    func makeRequest<T: Decodable>(completion: @escaping (_ data: Result<T, Error>) -> Void) {
        guard let urlString = self.url,
              let url = URL(string: urlString) else {
            fatalError("URL is not provided or something is wrong with it")
        }

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

        AF.request(request)
            .validate()
            .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
