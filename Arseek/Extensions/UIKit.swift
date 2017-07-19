//
//  UIKit.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - Storyboard

extension UIStoryboard {
    
    // Enumeration of all storyboard names used in the app
    enum Storyboard: String {
        case main
        
        /// The name of the storyboard's file, returned with capitalization applied
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) throws {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    /// Creates an instance of a view controller from a storyboard identifier
    /// Note: - The storyboard identifier must be set to the full view controller name
    func instantiateViewController<T: UIViewController>() throws -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            let error = StoryboardIdentifiableError.unrecognizedIdentifier
            print("\(error.errorDescription): \(T.storyboardIdentifier)")
            throw error
        }
        return viewController
    }
    
}

// MARK: - Storyboard Identifiable Error

enum StoryboardIdentifiableError: Error {
    
    case unrecognizedIdentifier
    case unrecognizedType
    
}

// MARK: - Localized Error

extension StoryboardIdentifiableError: LocalizedError {
    
    public var errorDescription: String {
        switch self {
        case .unrecognizedIdentifier: return "Unrecognized Identifier"
        case .unrecognizedType: return "Unrecognized Type"
        }
    }
    
}

// MARK: - View Controller

extension UIViewController: StoryboardIdentifiable { }

// MARK: - Table View Cell

extension UITableViewCell: StoryboardIdentifiable { }

// MARK: - Table View

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) throws -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.storyboardIdentifier, for: indexPath) as? T else {
            let error = StoryboardIdentifiableError.unrecognizedIdentifier
            print("\(error.errorDescription): \(T.storyboardIdentifier)")
            throw StoryboardIdentifiableError.unrecognizedIdentifier
        }
        return cell
    }
    
    func cellForRow<T: UITableViewCell>(at indexPath: IndexPath) throws -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            let error = StoryboardIdentifiableError.unrecognizedType
            print("\(error.errorDescription): \(T.self)")
            throw StoryboardIdentifiableError.unrecognizedType
        }
        return cell
    }
    
}
