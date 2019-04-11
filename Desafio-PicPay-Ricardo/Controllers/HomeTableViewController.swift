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
        setupNavigation()
        setupTableView()
        loadData()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.rowHeight = 80
    }
    
    // MARK: - API
    private func loadData() {
        viewModel.getUsers { [weak self] err in
            guard let self = self else { return }
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
        guard let cell = R.nib.userTableViewCell.firstView(owner: nil) else { return UITableViewCell() }
        let userVM = viewModel.user(at: indexPath.row)
        cell.setup(viewModel: userVM)
        return cell
    }
}
