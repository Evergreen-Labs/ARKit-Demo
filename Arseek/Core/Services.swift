//
//  Services.swift
//  Arseek
//
//  Created by Ian Rahman on 7/19/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

//
//  Services.swift
//  Victory
//
//  Created by Ian Rahman on 6/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Services

final class Services {
    
    let configuration = ConfigurationService()
    let location = LocationService()
    let formatter = FormatterService()
    
}

// MARK: - Configuration Service

struct ConfigurationService {
    
    let tableViewRowHeight: CGFloat = 55
    let titleFont = UIFont(name: "Helvetica Neue", size: 24)!
    let bodyFont = UIFont(name: "Helvetica Neue", size: 20)!
    let detailFont = UIFont(name: "Helvetica Neue", size: 16)!
    
}

// MARK: - Location Service

final class LocationService {
    
    let manager = CLLocationManager()
    
}

// MARK: - Formatter Service

final class FormatterService {
    
    private lazy var measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private lazy var dateFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    func formatted(measurement: Measurement<UnitLength>) -> String {
        return measurementFormatter.string(from: measurement)
    }
    
    func formatted(time: TimeInterval) -> String {
        return dateFormatter.string(from: time) ?? "0:00:00"
    }
    
}
