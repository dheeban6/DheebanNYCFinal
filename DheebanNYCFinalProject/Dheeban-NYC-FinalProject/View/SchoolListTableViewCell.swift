//
//  SchoolListTableViewCell.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

class SchoolListTableViewCell: UITableViewCell {
    
    // Labels for school name and city
    private let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Separator line view
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup UI elements
    private func setupUI() {
        contentView.addSubview(schoolNameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(separatorLine)
        
        // Constraints for schoolNameLabel
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            schoolNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            schoolNameLabel.trailingAnchor.constraint(equalTo: cityLabel.leadingAnchor, constant: -8),
            schoolNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        // Constraints for cityLabel
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cityLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // Constraints for separatorLine
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // Configure cell with data
    func configure(with school: NYCSchoolModel) {
            schoolNameLabel.text = school.school_name
            cityLabel.text = school.city
        }
}
