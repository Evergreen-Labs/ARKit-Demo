//
//  AppCoordinator.swift
//  Arseek
//
//  Created by Ian Rahman on 7/19/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - App Coordinator

final class AppCoordinator: NSObject, RootViewCoordinator {
    
    // MARK: - Properties
    
    let services: Services
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
    }
    
    // MARK: - Functions
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        showInitialViewController()
        setGeneralAppearance()
    }
    
    /// Populate navigation controller with initial view controller
    private func showInitialViewController() {
        if let storyboard = try? UIStoryboard(.main),
            let viewController: ViewController = try? storyboard.instantiateViewController() {
            viewController.coordinator = self
            navigationController.viewControllers = [viewController]
        }
    }
    
    private func setGeneralAppearance() {
        UILabel.appearance().font = services.configuration.bodyFont
    }
    
}
