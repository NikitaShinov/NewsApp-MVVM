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
    
    public func getNews(completion: @escaping (Result<[Article]?, Error>) -> Void) {
        
        guard let url = URL(string: Constants.url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
               
            }
            guard let data = data  else {return}
            
            let decodedData = try? JSONDecoder().decode(Response.self, from: data)
            
            if let data = decodedData {
                DispatchQueue.main.async {
                    completion(.success(data.articles))
                }
            }
        }.resume()
    }
}
