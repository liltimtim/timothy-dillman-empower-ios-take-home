//
//  BeneficiaryListViewModel.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
import Combine
import UIKit

class BeneficiaryListViewModel: NSObject, ObservableObject {
    private(set) var selectedBeneficiary: CurrentValueSubject<Beneficiary?, Never> = .init(nil)
    private(set) var data: CurrentValueSubject<[Beneficiary], Error> = .init([])
    private var store: DataStore!
    
    required init(with store: DataStore) {
        super.init()
        self.store = store
        loadFromStore()
    }
    
    func select(beneficiary: Beneficiary) {
        self.selectedBeneficiary.send(beneficiary)
    }
    
    func data(for indexPath: IndexPath) -> Beneficiary? {
        return data.value[safe: indexPath.row]
    }
    
    func refresh() {
        loadFromStore()
    }
    
    private func count() -> Int { return data.value.count }
    
    private func loadFromStore() {
        Task.detached { [weak self] in
            guard let self = self else { return }
            do {
                let results: [Beneficiary] = try await store.readFromStore()
                self.data.send(results)
            } catch let error {
                self.data.send(completion: .failure(error))
            }
        }
    }
}

extension BeneficiaryListViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeneficiaryContainerCell.reuseID, for: indexPath) as? BeneficiaryContainerCell else {
            fatalError("The registered cell with the table was not the one that was dequeued.")
        }
        // If for some reason we grab an index which is out of bounds we do not want to crash
        // we also cannot return a nil cell. Return a new table view cell not dequeued.
        // at worse, it will result in a blank cell to the user.
        guard let beneficiary = data(for: indexPath) else {
            return UITableViewCell()
        }
        cell.setContent(with: beneficiary, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if for some reason the user selects a beneficiary that is out of bounds, do nothing.
        guard let beneficiary = data(for: indexPath) else { return }
        select(beneficiary: beneficiary)
    }
}
