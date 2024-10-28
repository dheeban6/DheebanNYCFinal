//
//  SchoolListViewController.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit
import Combine

class SchoolListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var schools: [NYCSchoolModel] = []
    var coordinator: SchoolListCoordinator?
    private var tableView = UITableView()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupHeader()
        bindDataProvider()
    }
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply the appearance to the navigation bar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "School List"
        
        // Ensure the navigation bar is not translucent
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "School List"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SchoolListTableViewCell.self, forCellReuseIdentifier: "SchoolCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindDataProvider() {
        NYCSchoolDataProvider.shared.$schools
            .receive(on: DispatchQueue.main)
            .sink { [weak self] schools in
                self?.schools = schools
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupHeader() {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let schoolNameLabel = UILabel()
        schoolNameLabel.text = "School Name"
        schoolNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false

        let cityLabel = UILabel()
        cityLabel.text = "City"
        cityLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cityLabel.textAlignment = .right
        cityLabel.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(schoolNameLabel)
        headerView.addSubview(cityLabel)

        NSLayoutConstraint.activate([
            schoolNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            schoolNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            cityLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cityLabel.widthAnchor.constraint(equalToConstant: 100)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        tableView.tableHeaderView = headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NYCSchoolDataProvider.shared.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < schools.count else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as! SchoolListTableViewCell
        let school = schools[indexPath.row]
        cell.configure(with: school)
        return cell
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedSchool = schools[indexPath.row]
            
            // Fetch SAT details if available
            let satDetails = NYCSchoolDataProvider.shared.getSATDetails(for: selectedSchool.dbn)
            
            SchoolListCoordinator.shared.showSchoolDetails(school: selectedSchool, satDetails: satDetails)
    }
}
