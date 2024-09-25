//
//  SchoolListTableViewCell.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
import UIKit

class SchoolListTableViewCell: UITableViewCell {
    
    // Define labels for the school name and city
    let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let schoolCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup UI for the cell
    private func setupUI() {
        // Add labels to the content view
        contentView.addSubview(schoolNameLabel)
        contentView.addSubview(schoolCityLabel)
        
        // Add Auto Layout constraints for labels
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            schoolNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            schoolNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            schoolCityLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5),
            schoolCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            schoolCityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            schoolCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
