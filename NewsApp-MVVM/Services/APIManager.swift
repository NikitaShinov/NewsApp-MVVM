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
    
    public func getNews(completion: @escaping (_ news: Response) -> Void) {
        
        guard let url = URL(string: Constants.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Discription")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Response.self, from: data)
                let news = result.articles
                DispatchQueue.main.async {
                    completion(result)
                    print (news)
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }
        task.resume()
    }
}
