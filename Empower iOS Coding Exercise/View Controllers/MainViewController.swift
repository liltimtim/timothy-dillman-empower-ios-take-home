//
//  MainViewController.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
import UIKit
import Combine

class MainViewController: UINavigationController {
    private var beneficiaryListController: BeneficiaryListViewController!
    private var viewModel: MainViewControllerViewModel!
    private var subscriptions: Set<AnyCancellable> = []
    
    required init(store: DataStore, viewModel: MainViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        registerSubscriptions()
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        navigationBar.prefersLargeTitles = true
        beneficiaryListController = BeneficiaryListViewController(with: viewModel.beneficiaryListViewModel)
        setViewControllers([beneficiaryListController], animated: false)
    }
    
    private func registerSubscriptions() {
        viewModel
            .beneficiaryListViewModel
            .selectedBeneficiary
            .compactMap { $0 } // filter nil values
            .sink {[weak self] b in
                self?.pushViewController(BeneficiaryDetailViewController(viewModel: .init(beneficiary: b)), animated: true)
            }
            .store(in: &subscriptions)
    }
}
