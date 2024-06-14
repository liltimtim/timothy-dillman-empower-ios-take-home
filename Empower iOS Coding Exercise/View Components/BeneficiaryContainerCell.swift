//
//  BeneficiaryContainerCell.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
import UIKit

class BeneficiaryContainerCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private let benefitTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let designationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    static var reuseID: String { return String(describing: Self.self) }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: BeneficiaryContainerCell.reuseID)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("We have not implemented this initialization method. Do not use it.")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // ensure reused cell does not display old data.
        clearForDequeue()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setContent(with beneficiary: Beneficiary, at indexPath: IndexPath) {
        // Setup Accessibility
        // Help automation identify specific cells that have stable non-natural keys
        // Example: beneficiary_0_0, beneficiary_0_1
        accessibilityIdentifier = "beneficiary_\(indexPath.section)_\(indexPath.row)"
        // setup human label
        accessibilityLabel = "Beneficiary \(beneficiary.fullName). \(beneficiary.beneType). Designation \(beneficiary.disignationCodeDisplay.display())"
        // setup human hint for action
        accessibilityHint = "Select to view more details of beneficiary"
        accessoryType = .disclosureIndicator
        
        // setup display UI
        nameLabel.text = beneficiary.fullName
        benefitTypeLabel.text = beneficiary.beneType
        designationLabel.text = "\(beneficiary.designationCode) - \(beneficiary.disignationCodeDisplay.display())"
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(benefitTypeLabel)
        contentView.addSubview(designationLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        benefitTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        designationLabel.translatesAutoresizingMaskIntoConstraints = false
        /**
         cell will look something like this
         |--------------------|
         | TestFirst E Example
         | Child
         | P - Primary
         |--------------------|
         */
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            benefitTypeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            benefitTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            benefitTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            designationLabel.topAnchor.constraint(equalTo: benefitTypeLabel.bottomAnchor, constant: 8),
            designationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            designationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            designationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func clearForDequeue() {
        nameLabel.text = nil
        benefitTypeLabel.text = nil
        designationLabel.text = nil
    }
}
