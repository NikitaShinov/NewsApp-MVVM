//
//  NewsDetailsViewModel.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

protocol NewsDetailsViewModelProtocol: AnyObject {
    
    var newsTitle: String { get }
    var newsDescription: String { get }
    var imageData: Data? { get }
    
    init (news: Article)
    
}

class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
    var newsTitle: String {
        news.title
    }
    
    var newsDescription: String {
        news.description ?? "No preview avaliable"
    }
    
    var imageData: Data? {
        ImageManager.shared.getImage(from: news.urlToImage)
    }
    
    private let news: Article
    
    required init(news: Article) {
        self.news = news
    }
    
    
}
