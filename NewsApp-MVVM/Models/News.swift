//
//  News.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

struct Response: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: URL?
    let content: String
    var countOfViews: Int? = 0
}
