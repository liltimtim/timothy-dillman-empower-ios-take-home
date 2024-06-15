//
//  BeneficiaryDetailViewController.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
import UIKit

class BeneficiaryDetailViewModel {
    private(set) var beneficiary: Beneficiary!
    
    init(beneficiary: Beneficiary) {
        self.beneficiary = beneficiary
    }
}

class BeneficiaryDetailViewController: UIViewController {
    private var viewModel: BeneficiaryDetailViewModel!
    private var socialSecurityNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    required init(viewModel: BeneficiaryDetailViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(beneficiary: viewModel.beneficiary)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init via coder has not been implemented. Please do not use this.")
    }
    
    private func setupUI(beneficiary: Beneficiary) {
        title = beneficiary.fullName
        view.backgroundColor = .white
        
        view.addSubview(socialSecurityNumberLabel)
        socialSecurityNumberLabel.text = "Social Security Number: \(beneficiary.socialSecurityNumber)"
        socialSecurityNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        socialSecurityNumberLabel.accessibilityLabel = "Social Security Number: \(beneficiary.socialSecurityNumber)"
        socialSecurityNumberLabel.accessibilityIdentifier = "social_security_number_label"
        
        view.addSubview(dateOfBirthLabel)
        dateOfBirthLabel.text = "Birthday \(beneficiary.dateOfBirthDisplay ?? "")"
        dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthLabel.accessibilityLabel = "Birthday \(beneficiary.dateOfBirthDisplay ?? "not available")"
        dateOfBirthLabel.accessibilityIdentifier = "date_of_birth_label"
        
        view.addSubview(phoneNumberLabel)
        phoneNumberLabel.text = "Phone number: \(beneficiary.phoneNumber)"
        
        // we use character which supports potentially exotic things like emojis.
        // this will ensure that even if emojis becomes phone numbers, we can still read them out in accessibilty
        var chars: [Character] = []
        for char in beneficiary.phoneNumber {
            chars.append(char)
        }
        // we create one off accessibilty here otherwise it will read the number as "1 billion etc etc" which is not helpful
        let accessibilityPhoneLabel = chars.map { c in return "\(c)" }.joined(separator: " ")
        phoneNumberLabel.accessibilityLabel = "Phone number: \(accessibilityPhoneLabel)"
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.accessibilityIdentifier = "phone_number_label"
        
        let address = beneficiary.beneficiaryAddress
        view.addSubview(addressLabel)
        addressLabel.text = address.addressFormatted
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.accessibilityLabel = "Beneficiary address: \(address.addressFormatted)"
        addressLabel.numberOfLines = 0
        addressLabel.accessibilityIdentifier = "address_label"
        
        NSLayoutConstraint.activate([
            socialSecurityNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            socialSecurityNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            socialSecurityNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            dateOfBirthLabel.topAnchor.constraint(equalTo: socialSecurityNumberLabel.bottomAnchor, constant: 8),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            dateOfBirthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        
        addressLabel.layoutIfNeeded()
    }
}
