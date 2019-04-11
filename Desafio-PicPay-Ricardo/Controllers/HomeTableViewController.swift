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
        observeNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationLargeTitle()
    }
    
    private func setupTableView() {
        tableView.rowHeight = 80
    }
    
    private func observeNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showPaymentSuccess), name: .paymentSuccess, object: nil)
    }
    
    @objc private func showPaymentSuccess(_ notification: Notification) {
        if let viewModel = NotificationCenterManager.retrievePaymentSuccess(notification) {
            print("Suuucessoooooo", viewModel.response?.transaction.id ?? "")
        }
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
                for (index, cell) in self.tableView.visibleCells.enumerated() {
                    cell.transform = CGAffineTransform(translationX: 0, y: 80)
                    UIView.animate(withDuration: 0.5, delay: 0.05 * Double(index), usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: [.curveEaseInOut], animations: {
                        cell.transform = .identity
                    })
                }
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
        let userVM = viewModel.user(at: indexPath.row)
        viewModel.paymentViewModel.setUser(user: userVM.user)
        
        if let savedCard = viewModel.paymentViewModel.savedCard {
            viewModel.paymentViewModel.setCreditCard(card: savedCard)
            self.performSegue(withIdentifier: R.segue.homeTableViewController.goToConfirmation, sender: nil)
        } else {
            self.performSegue(withIdentifier: R.segue.homeTableViewController.goToCreditCardOnboarding, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueVC = R.segue.homeTableViewController.goToCreditCardOnboarding(segue: segue) {
            segueVC.destination.paymentFlowViewModel = viewModel.paymentViewModel
        } else if let segueVC = R.segue.homeTableViewController.goToConfirmation(segue: segue) {
            segueVC.destination.paymentFlowViewModel = viewModel.paymentViewModel

        }
    }
}

extension HomeTableViewController: SearchHeaderDelegate {
    func textDidChange(_ text: String) {
        viewModel.filterUsers(text: text)
        tableView.reloadData()
        
    }
}
