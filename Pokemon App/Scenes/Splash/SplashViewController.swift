//
//  SplashViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import Foundation

class SplashViewController: BaseViewController {
    static func instance() -> SplashViewController? {
        return instance(fromName: "Splash")
    }
}
