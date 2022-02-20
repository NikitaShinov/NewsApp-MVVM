//
//  NewsListViewModel.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

class NewsViewModel {
    
    var newsArray = [Article]()
    var onUpdate: () -> Void = {}
    var onUpdateError: () -> Void = {}
    
    func fetchNews(completion: @escaping(Result<[Article]?, Error>) -> Void) {
        APICaller.shared.getNews { [weak self] result in
            switch result {
            case .success(let receivedArticles):
                guard let receivedArticles = receivedArticles else { return }
                self?.newsArray = receivedArticles
                completion(.success(receivedArticles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func refreshNews(completion: @escaping(Result<[Article], Error>) -> Void) {
        APICaller.shared.getNews { [weak self] result in
            switch result {
            case .success(let receivedArticles):
                guard let receivedArticles = receivedArticles else { return }
                self?.newsArray = receivedArticles
                do {
                    let encoder = JSONEncoder()
                    let encoded = try encoder.encode(self?.newsArray)
                    UserDefaults.standard.set(encoded, forKey: "articles")
                } catch {
                }
                completion(.success(receivedArticles))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configureNews(completion: @escaping([Article]) -> Void) {
        if let articles = UserDefaults.standard.data(forKey: "articles") {
            do {
                let decoder = JSONDecoder()
                let news = (try decoder.decode([Article].self,
                                                   from: articles)).enumerated().compactMap { $0.offset < 20 ? $0.element : nil }
                completion(news)
            } catch {
                print (error.localizedDescription)
            }
        } else {
            fetchNews { [weak self] result in
                switch result {
                case .success(let receivedArticles):
                    do {
                        let encoder = JSONEncoder()
                        let articles = try encoder.encode(receivedArticles)
                        UserDefaults.standard.set(articles, forKey: "articles")
                        self?.onUpdate()
                    } catch {
                        
                    }
                case .failure(_):
                    print ("error")
                    self?.onUpdateError()
                }
            }
        }
    }
    
    func countTaps(indexPath: IndexPath, viewModel: NewsViewModel) {
        var article = newsArray[indexPath.row]
        if var count = article.countOfViews {
            count += 1
            article.countOfViews = count
        } else {
            article.countOfViews = 1
        }
        viewModel.newsArray[indexPath.row] = article
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newsArray)
            UserDefaults.standard.set(data, forKey: "articles")
        } catch {
            print (error)
        }
    }
    
}
