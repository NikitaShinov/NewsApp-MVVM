//
//  NewsListTableViewController.swift
//  NewsApp-MVVM
//
//  Created by max on 17.02.2022.
//

import UIKit
import SafariServices

class NewsListTableViewController: UITableViewController {
    
    var viewModel: NewsViewModel!
    
    let spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = NewsViewModel()
        viewModel.configureNews { [weak self] result in
            DispatchQueue.main.async {
                self?.viewModel.newsArray.append(contentsOf: result)
                self?.showSpinnerLoadingView(isShowing: false)
                self?.tableView.reloadData()
            }
        }
        viewModel.onUpdate = {
            DispatchQueue.main.async {
                self.showSpinnerLoadingView(isShowing: false)
                self.tableView.reloadData()
            }
        }
        
        viewModel.onUpdateError = {
            DispatchQueue.main.async {
                self.showSpinnerLoadingView(isShowing: false)
                self.tableView.reloadData()
            }
        }
        
                
    }
    
    private func configureUI() {
        title = "NEWS"
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
    
    let pulltoRefresh: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
            return refreshControl
        }()
        
        @objc private func refresh(sender: UIRefreshControl) {
            viewModel.refreshNews { [weak self] (result) in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        //indicator activivty stop
                        self?.showSpinnerLoadingView(isShowing: false)
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    self?.showSpinnerLoadingView(isShowing: false)
                    self?.showAlert(title: "No Internet", message: "Check your Internet Connection")
                    
                   
                }
            }
            sender.endRefreshing()
        }
    
    private func showSpinnerLoadingView(isShowing: Bool) {
        if isShowing {
            self.spinner.isHidden = false
            spinner.startAnimating()
        } else if spinner.isAnimating {
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }
    
    func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as! NewsListTableViewCell
        cell.configureCell(with: viewModel, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.countTaps(indexPath: indexPath, viewModel: viewModel)
        tableView.reloadData()
        
        let item = viewModel.newsArray[indexPath.row]
        
        guard let url = item.url else { return }
        guard let url = URL(string: url) else { return }
        
        let config = SFSafariViewController.Configuration()
        let safariVC = SFSafariViewController(url: url, configuration: config)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
        
    }

}
