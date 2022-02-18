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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Discription")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.articles))
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }
        .resume()
    }
}
