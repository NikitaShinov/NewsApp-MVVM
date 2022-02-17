//
//  NewsListTableViewController.swift
//  NewsApp-MVVM
//
//  Created by max on 17.02.2022.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var viewModel: NewsListViewModelProtocol! {
        didSet {
            viewModel.fetchNews {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NEWS"
        viewModel = NewsListViewModel()
        tableView.register(NewsListTableViewCell.self,
                           forCellReuseIdentifier: NewsListTableViewCell.identifier)
        view.backgroundColor = .systemBackground
        
    }
    
    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as! NewsListTableViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

}
