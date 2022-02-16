//
//  APIManager.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    public func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard let url = URL(string: Constants.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    print (result.articles)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
