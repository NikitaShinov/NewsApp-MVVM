//
//  ViewController.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getNews { result in
            switch result {
            case .success(let articles):
                print (articles)
            case .failure(let error):
                print (error)
            }
        }
    }


}

