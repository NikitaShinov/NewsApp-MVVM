//
//  Constants.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

enum Constants {
    static let url = "https://newsapi.org/v2/top-headlines?country=us&category=sport&apiKey=5b857b468411402e93e521c8ccfe22e0"
}

enum CurrentDate {
    static let date = Date()
    static let dateFormatted = date.getFormattedDate(format: "yyyy-MM-dd")
}
