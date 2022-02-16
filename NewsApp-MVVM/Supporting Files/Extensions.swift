//
//  Extensions.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
