//
//  SchoolDetailViewController.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    private let school: NYCSchoolModel
    private let satDetails: NYCSchoolSATModel?

    // Custom initializer accepting school and SAT details
    init(school: NYCSchoolModel, satDetails: NYCSchoolSATModel?) {
        self.school = school
        self.satDetails = satDetails
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UI Elements
    private let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let satReadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let satMathLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let satWritingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .blue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Adding subviews
        view.addSubview(schoolNameLabel)
        view.addSubview(satReadingLabel)
        view.addSubview(satMathLabel)
        view.addSubview(satWritingLabel)
        view.addSubview(overviewLabel)
        view.addSubview(phoneLabel)
        view.addSubview(websiteLabel)

        // Setting up constraints
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            schoolNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            schoolNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            satReadingLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 20),
            satReadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            satReadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            satMathLabel.topAnchor.constraint(equalTo: satReadingLabel.bottomAnchor, constant: 8),
            satMathLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            satMathLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            satWritingLabel.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor, constant: 8),
            satWritingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            satWritingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            overviewLabel.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            phoneLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            websiteLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            websiteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func populateData() {
        // Populate data for the school and SAT details
        schoolNameLabel.text = school.school_name
        satReadingLabel.text = "SAT Reading: \(satDetails?.sat_critical_reading_avg_score ?? "N/A")"
        satMathLabel.text = "SAT Math: \(satDetails?.sat_math_avg_score ?? "N/A")"
        satWritingLabel.text = "SAT Writing: \(satDetails?.sat_writing_avg_score ?? "N/A")"
        overviewLabel.text = school.overview_paragraph ?? "No overview available"
        phoneLabel.text = "Phone: \(school.phone_number ?? "N/A")"
        websiteLabel.text = "Website: \(school.website ?? "N/A")"
    }
}
