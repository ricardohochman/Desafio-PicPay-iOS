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
    
    // MARK: - Card
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController: PaymentSuccessViewController!
    var visualEffectView: UIVisualEffectView!
    
    var cardHeight: CGFloat = 0.0
    
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    func setupCard(viewModel: PaymentFlowViewModel) {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardViewController = PaymentSuccessViewController(nibName: "PaymentSuccessViewController", bundle: nil)
        cardViewController.viewModel = viewModel
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        cardHeight = cardViewController.view.frame.height
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHeight, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        animateTransitionIfNeeded(state: .expanded, duration: 0.9)
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    self.tableView.isScrollEnabled = false
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height
                    self.tableView.isScrollEnabled = true
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
                if state == .collapsed {
                    self.cardViewController.view.removeFromSuperview()
                }
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    // MARK: - Life Cycle
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
            setupCard(viewModel: viewModel)
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
