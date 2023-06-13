//
//  OrientationManager.swift
//  Navigation
//
//  Created by Roman Vakulenko on 13.06.2023.
//

import UIKit

class OrientationManager {
    static let shared = OrientationManager()
    var currentOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    private init() {}
    func start() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    func stop() {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    deinit {
        stop()
    }
}
