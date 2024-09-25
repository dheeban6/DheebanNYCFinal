//
//  SchoolDetailViewController.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    // Custom initializer accepting schoolInfo and SAT details
        init(schoolInfo: NYCSchoolModel, schoolSATDetails: NYCSchoolSATModel?) {
            self.schoolInfo = schoolInfo
            self.schoolSATDetails = schoolSATDetails
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Label to display the school name as a header
    private let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Labels for displaying SAT scores
    private let satReadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let satMathLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let satWritingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Overview section
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "OVERVIEW"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Contact Information section
    private let contactInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "CONTACT INFORMATION"
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    // ScrollView to contain all content
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var schoolSATDetails: NYCSchoolSATModel? = nil
    var schoolInfo: NYCSchoolModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Adding all UI elements to contentView
        contentView.addSubview(schoolNameLabel)
        contentView.addSubview(satReadingLabel)
        contentView.addSubview(satMathLabel)
        contentView.addSubview(satWritingLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewContentLabel)
        contentView.addSubview(contactInfoLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(websiteLabel)
        
        // Constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Adjusted constraints for the school name label (now it will be placed properly at the top)
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20), // Header at the top of contentView
            schoolNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            schoolNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Adjusted SAT Reading Label to be below school name label
            satReadingLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 20),
            satReadingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            satReadingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            satMathLabel.topAnchor.constraint(equalTo: satReadingLabel.bottomAnchor, constant: 8),
            satMathLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            satMathLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor),
            
            satWritingLabel.topAnchor.constraint(equalTo: satMathLabel.bottomAnchor, constant: 8),
            satWritingLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            satWritingLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor)
        ])
        
        // Constraints for Overview Section
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: satWritingLabel.bottomAnchor, constant: 30),
            overviewLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor),
            
            overviewContentLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 8),
            overviewContentLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            overviewContentLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor)
        ])
        
        // Constraints for Contact Info Section
        NSLayoutConstraint.activate([
            contactInfoLabel.topAnchor.constraint(equalTo: overviewContentLabel.bottomAnchor, constant: 30),
            contactInfoLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            contactInfoLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor),
            
            websiteLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: satReadingLabel.leadingAnchor),
            websiteLabel.trailingAnchor.constraint(equalTo: satReadingLabel.trailingAnchor),
            websiteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }

    
    private func populateData() {
        // Populate the school name
        schoolNameLabel.text = schoolInfo?.school_name
        // Populate SAT Scores
        satReadingLabel.text = "SAT Average Reading Score: \(schoolSATDetails?.sat_critical_reading_avg_score ?? "N/A")"
        satMathLabel.text = "SAT Average Math Score: \(schoolSATDetails?.sat_math_avg_score ?? "N/A")"
        satWritingLabel.text = "SAT Average Writing Score: \(schoolSATDetails?.sat_writing_avg_score ?? "N/A")"
        
        // Populate Overview
        overviewContentLabel.text = schoolInfo?.overview_paragraph ?? "Overview not available"
        
        // Populate Contact Info
        phoneLabel.text = schoolInfo?.phone_number ?? "Phone number not available"
        websiteLabel.text = schoolInfo?.website ?? "Website not available"
    }
}
