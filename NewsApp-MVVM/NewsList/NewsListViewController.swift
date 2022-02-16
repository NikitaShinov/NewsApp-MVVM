//
//  NewsListViewController.swift
//  NewsApp-MVVM
//
//  Created by max on 16.02.2022.
//

import UIKit

class NewsListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsListTableViewCell.self,
                       forCellReuseIdentifier: NewsListTableViewCell.identifier)
        return table
    }()
    
    private var viewModel: NewsListViewModelProtocol! {
        didSet {
            viewModel.fetchNews {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
