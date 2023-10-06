//
//  BaseViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit
import RxSwift

// MARK: StoryboardInstantiable
protocol StoryboardInstantiable {
    static func instance(fromName name: String) -> Self?
}

// MARK: BaseViewController
class BaseViewController: UIViewController {
    private let disposeBag = DisposeBag()

    // MARK: UI Components
    private var loadingView: UIView!
    private var activityIndicator: UIActivityIndicatorView!

    // MARK: MVVM-C Components
    var baseVM: BaseViewModelProtocol? {
        didSet {
            baseVM?.isLoading.subscribe { [weak self] isLoading in
                guard let self else { return }

                if isLoading.element == true {
                    self.showLoading()
                } else {
                    self.hideLoading()
                }
            }.disposed(by: disposeBag)
        }
    }

    var baseCoordinator: BaseCoordinatorProtocol?
    
    override func viewDidLoad() {
        setupUI()
    }
}

// MARK: Configuration
private extension BaseViewController {
    final func setupUI() {
        setupLoadingIndicator()
    }

    final func setupLoadingIndicator() {
        loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView.center
        activityIndicator.frame = view.bounds.offsetBy(dx: 0, dy: 64)

        loadingView.addSubview(activityIndicator)
    }
}

// MARK: Public
extension BaseViewController {
    final func showLoading() {
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }

    final func hideLoading() {
        loadingView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}

// MARK: StoryboardInstantiable
extension BaseViewController: StoryboardInstantiable {
    static func instance(fromName name: String) -> Self? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return instance(fromStoryboard: storyboard)
    }

    private static func instance(fromStoryboard storyboard: UIStoryboard) -> Self? {
        return storyboard.instantiateViewController(identifier: String(describing: Self.self)) as? Self
    }
}
