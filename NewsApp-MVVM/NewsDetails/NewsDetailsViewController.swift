//
//  NewsDetailsViewController.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var viewModel: NewsDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        print (viewModel.newsTitle)

    }
    



}
