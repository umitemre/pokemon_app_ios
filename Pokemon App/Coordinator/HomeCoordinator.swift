//
//  HomeCoordinator.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: HomeCoordinator
class HomeCoordinator: BaseCoordinator {
    override func start() {
        guard let controller = HomeViewController.instance() else { return }
        controller.coordinator = self
        controller.searchViewController = getSearchController()
        controller.favoritesViewController = getFavoritesController()
        
        navigationController = UINavigationController(rootViewController: controller)
        getSceneDelegate()?.window?.rootViewController = navigationController
    }
}

// MARK: Public
extension HomeCoordinator{
    final func routeToCardDetail(_ card: Card) {
        guard let controller = CardDetailViewController.instance(withCard: card) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: Private
private extension HomeCoordinator {
    final func getSceneDelegate() -> SceneDelegate? {
        let application = UIApplication.shared

        guard let windowScene = application.connectedScenes.first as? UIWindowScene else { return nil }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return nil }

        return sceneDelegate
    }
    
    final func getSearchController() -> SearchViewController? {
        let controller = SearchViewController.instance()
        let repository = CardRepository()
        let viewModel = SearchViewModel(repository: repository)
        controller?.viewModel = viewModel
        controller?.coordinator = self
        
        return controller
    }
    
    final func getFavoritesController() -> FavoritesViewController? {
        let controller = FavoritesViewController.instance()
        return controller
    }
}
