//
//  SplashViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit
import Reachability

// MARK: SplashViewController
class SplashViewController: BaseViewController {
    // MARK: Outlets
    @IBOutlet private weak var appTitleLabel: UILabel!
    
    // MARK: MVVM-C Component
    var coordinator: ApplicationCoordinator? {
        get { baseCoordinator as? ApplicationCoordinator }
        set { baseCoordinator = newValue }
    }

    static func instance() -> SplashViewController? {
        return instance(fromName: "Splash")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkInternetConnection()
    }
}

// MARK: Configuration
private extension SplashViewController {
    final func configureUI() {
        configureAppTitleLabel()
    }
    
    final func configureAppTitleLabel() {
        // appTitleLabel.alpha = 0.0
        appTitleLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1).rotated(by: CGFloat.pi)
    }
}

// MARK: Private
private extension SplashViewController {
    /// Checks internet connection then proceeds to the boot if there's an active internet connection
    /// If there's no internet connection, it warns user indicationg an active internet connection is required.
    final func checkInternetConnection() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            showNoInternetConnectionPopup()
            return
        }
        
        onInternetConnectionSuccess()
    }

    final func showNoInternetConnectionPopup() {
        let alert = UIAlertController(title: "No Internet Connection", message: "An internet connection is required to continue. Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.checkInternetConnection()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    final func onInternetConnectionSuccess() {
        animateAppName()
    }
}

// MARK: Animation
private extension SplashViewController {
    final func animateAppName() {
        UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [weak self] in
            guard let self else { return }

            self.appTitleLabel.alpha = 1.0
            self.appTitleLabel.transform = .identity
        }) { [weak self] _ in
            guard let self else { return }

            self.showLoading()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self else { return }
                
                self.onAnimationCompleted()
            }
        }
    }
    
    final func onAnimationCompleted() {
        hideLoading()
        coordinator?.routeToHome()
    }
}
