//
//  BeneficiaryListViewController.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import UIKit
import Combine

class BeneficiaryListViewController: UITableViewController {
    private var viewModel: BeneficiaryListViewModel!
    private var subscriptions: Set<AnyCancellable> = []
    private var refreshCtrl: UIRefreshControl = .init()
    
    // MARK: - Init Methods
    
    required init(with viewModel: BeneficiaryListViewModel) {
        super.init(style: .plain)
        title = "Beneficiary List"
        self.viewModel = viewModel
        tableView.register(BeneficiaryContainerCell.self, forCellReuseIdentifier: BeneficiaryContainerCell.reuseID)
        tableView.delegate = self.viewModel
        tableView.dataSource = self.viewModel
        tableView.refreshControl = refreshCtrl
        registerSubscriptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("We have not implemented initializer with a coder. Do not use this.")
    }
    
    deinit {
        subscriptions.removeAll() // make sure we dispose of subscriptions
    }
    
    // MARK: - Beneficiary Private Methods
    
    private func registerSubscriptions() {
        viewModel
            .data
            .receive(on: DispatchQueue.main) // ensure receive on main thread
            .sink {[weak self] completion in
            switch completion {
            case .finished:
                self?.endRefreshAndReload()
                break
            case .failure(let err):
                self?.endRefreshAndReload()
                print(err)
            }
        } receiveValue: { [weak self] _ in
            self?.endRefreshAndReload()
        }
        .store(in: &subscriptions)
        
        refreshCtrl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        viewModel.refresh()
    }
    
    private func endRefreshAndReload() {
        refreshCtrl.endRefreshing()
        tableView.reloadData()
    }
}
