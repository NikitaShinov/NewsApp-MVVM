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
        viewModel = NewsListViewModel()
        title = "News"
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else { fatalError() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    
}
