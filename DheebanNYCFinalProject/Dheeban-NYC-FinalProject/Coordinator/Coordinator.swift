//
//  Coordinator.swift
//  DheebanNYCFinalProject
//
//  Created by Dheeban Jaga on 10/24/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
