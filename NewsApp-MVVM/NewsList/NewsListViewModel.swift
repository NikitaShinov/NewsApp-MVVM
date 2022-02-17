//
//  NewsListViewModel.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

protocol NewsListViewModelProtocol {
    var news: [Article] { get }
    func fetchNews(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> NewsListTableViewCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol
}

class NewsListViewModel: NewsListViewModelProtocol {
    
    var news: [Article] = []
    
    func fetchNews(completion: @escaping () -> Void) {
        APICaller.shared.getNews { [unowned self] news in
            self.news = news.articles
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        news.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> NewsListTableViewCellViewModelProtocol {
        let article = news[indexPath.row]
        return NewsTableViewCellViewModel(news: article)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol{
        let article = news[indexPath.row]
        return NewsDetailsViewModel(news: article)
    }
    
    
}
