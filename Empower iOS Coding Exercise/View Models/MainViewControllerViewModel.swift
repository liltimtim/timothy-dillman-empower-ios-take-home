//
//  MainViewControllerViewModel.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
import Combine

class MainViewControllerViewModel {
    private(set) var dataStore: DataStore!
    private(set) var beneficiaryListViewModel: BeneficiaryListViewModel!
    
    init(store: DataStore) {
        self.dataStore = store
        self.beneficiaryListViewModel = .init(with: dataStore)
    }
    
}
