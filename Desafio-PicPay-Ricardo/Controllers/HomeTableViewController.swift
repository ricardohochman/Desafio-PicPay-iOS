//
//  HomeTableViewController.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Constants
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 80
    }
    
    // MARK: - API
    private func loadData() {
        self.showActivityIndicator()
        viewModel.getUsers { [weak self] err in
            guard let self = self else { return }
            self.removeActivityIndicator()
            if let err = err {
                print("Falha em carregar o dados", err.localizedDescription)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = R.nib.userTableViewCell(owner: nil) else { return UITableViewCell() }
        let userVM = viewModel.user(at: indexPath.row)
        cell.setup(viewModel: userVM)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = R.nib.searchHeaderTableViewCell(owner: nil) else { return nil }
        header.setup(text: viewModel.getSearchText(), delegate: self)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = viewModel.user(at: indexPath.row)
        self.performSegue(withIdentifier: R.segue.homeTableViewController.goToCreditCardOnboarding, sender: nil)
    }
}

extension HomeTableViewController: SearchHeaderDelegate {
    func textDidChange(_ text: String) {
        viewModel.filterUsers(text: text)
        tableView.reloadData()
        
    }
}
