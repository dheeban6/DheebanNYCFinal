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
    
    // Declare the button correctly as a property of the class
    private let navigateButton: UIButton = {
        let button = UIButton()
        button.setTitle("NYC School List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
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
        view.addSubview(navigateButton)
        view.addSubview(activityIndicator)
        
        navigateButton.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)
        
        // Layout constraints for welcomeLabel, schoolImageView, and button
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            schoolImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            schoolImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            schoolImageView.widthAnchor.constraint(equalToConstant: 200),
            schoolImageView.heightAnchor.constraint(equalToConstant: 200),
            
            navigateButton.topAnchor.constraint(equalTo: schoolImageView.bottomAnchor, constant: 40),
            navigateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigateButton.widthAnchor.constraint(equalToConstant: 200),
            navigateButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: navigateButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func bindViewModel() {
        // Bind the loading state to the activity indicator
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.navigateButton.isEnabled = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.navigateButton.isEnabled = true
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func navigateButtonTapped() {
        viewModel.fetchData { [weak self] in
            // Once data is fetched, navigate to school list screen
            self?.viewModel.navigateToSchoolList()
        }
    }
}
