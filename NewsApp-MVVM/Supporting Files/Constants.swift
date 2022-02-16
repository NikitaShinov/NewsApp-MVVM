//
//  Constants.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

enum Constants {
    static let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=\(CurrentDate.dateFormatted)&sortBy=publishedAt&apiKey=5b857b468411402e93e521c8ccfe22e0")
}

enum CurrentDate {
    static let date = Date()
    static let dateFormatted = date.getFormattedDate(format: "yyyy-MM-dd")
}
