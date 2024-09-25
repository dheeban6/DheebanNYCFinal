//
//  SchoolListViewController.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit
import Combine

class SchoolListViewController: UIViewController {
    private let viewModel: SchoolListViewModel
    var coordinator: SchoolListCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    // UI Components
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // Sorting State
    var isSortingByNameAscending = true
    var isSortingByCityAscending = true

    init(viewModel: SchoolListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "NYC School List"
        view.backgroundColor = .white
        
        // Setup Table View
        tableView.register(SchoolListTableViewCell.self, forCellReuseIdentifier: "schoolCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // Setup constraints for tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Add search bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func bindViewModel() {
        viewModel.$schools
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension SchoolListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Set up header for sorting by School Name and City
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        let schoolNameLabel = UILabel()
        schoolNameLabel.text = "School Name"
        schoolNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        schoolNameLabel.textAlignment = .center
        schoolNameLabel.isUserInteractionEnabled = true
        let schoolTap = UITapGestureRecognizer(target: self, action: #selector(sortBySchoolName))
        schoolNameLabel.addGestureRecognizer(schoolTap)
        
        let cityLabel = UILabel()
        cityLabel.text = "City"
        cityLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cityLabel.textAlignment = .center
        cityLabel.isUserInteractionEnabled = true
        let cityTap = UITapGestureRecognizer(target: self, action: #selector(sortByCity))
        cityLabel.addGestureRecognizer(cityTap)
        
        headerView.addSubview(schoolNameLabel)
        headerView.addSubview(cityLabel)
        
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            schoolNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            schoolNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            schoolNameLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.5),
            
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            cityLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cityLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.5)
        ])
        
        return headerView
    }
    
    @objc func sortBySchoolName() {
        isSortingByNameAscending.toggle()
        viewModel.sortBySchoolName(ascending: isSortingByNameAscending)
    }
    
    @objc func sortByCity() {
        isSortingByCityAscending.toggle()
        viewModel.sortByCity(ascending: isSortingByCityAscending)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSchools()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as! SchoolListTableViewCell
        let school = viewModel.school(at: indexPath.row)
        cell.schoolNameLabel.text = school.school_name
        cell.schoolCityLabel.text = school.city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSchool = viewModel.school(at: indexPath.row)
        // Find the corresponding SAT details for the selected school
        let selectedSchoolSATDetails = viewModel.satDetails(for: selectedSchool.dbn)
            
            // Pass both school info and SAT details to the coordinator
            coordinator?.showSchoolDetails(school: selectedSchool, satDetails: selectedSchoolSATDetails)
    }
}

extension SchoolListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewModel.filterSchools(by: searchText)
    }
}
