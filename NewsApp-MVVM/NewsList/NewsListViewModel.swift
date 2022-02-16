//
//  NewsListViewModel.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

protocol NewsListViewModelProtocol: AnyObject {
    var news: [Article] { get }
    func fetchNews(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> NewsListTableViewCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> NewsListViewModelProtocol
}

class NewsListViewModel: NewsListViewModelProtocol {
    var news: [Article] = []
    
    func fetchNews(completion: @escaping () -> Void) {
        APICaller.shared.getNews { [unowned self] result in
            switch result {
            case .success(let news):
                self.news = news
            case .failure(let error):
                print (error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        news.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> NewsListTableViewCellViewModelProtocol {
        let article = news[indexPath.row]
        return NewsTableViewCellViewModel(news: article)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> NewsListViewModelProtocol {
        let article = news[indexPath.row]
        return NewsListViewModel()
    }
    
    
}
