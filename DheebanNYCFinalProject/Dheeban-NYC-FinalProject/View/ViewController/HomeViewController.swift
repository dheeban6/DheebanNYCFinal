//
//  HomeViewController.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    var coordinator: AppCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello,\nWelcome to the NYC Schools app!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nycSchoolImage") // Add this image to your assets
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NYCSchoolList", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(viewModel: HomeViewModel) {
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
        view.backgroundColor = .white
        
        // Add the welcome label, image view, and button
        view.addSubview(welcomeLabel)
        view.addSubview(schoolImageView)
        view.addSubview(button)
        view.addSubview(activityIndicator)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Layout constraints for welcomeLabel, schoolImageView, and button
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            schoolImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            schoolImageView.widthAnchor.constraint(equalToConstant: 200),
            schoolImageView.heightAnchor.constraint(equalToConstant: 200),
            
            button.topAnchor.constraint(equalTo: schoolImageView.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
        ])
    }
    
    private func bindViewModel() {
        // Bind the loading state to the activity indicator
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.button.isEnabled = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.button.isEnabled = true
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func buttonTapped() {
        // When the button is tapped, trigger the API call and wait for completion
        viewModel.fetchData { [weak self] in
            // Once the data is fetched, navigate to the school list
            self?.coordinator?.showSchoolList()
        }
    }
}
