//
//  AppCoordinator.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import Cordux

final class AppCoordinator: SceneCoordinator, SubscriberType {
    enum RouteSegment: String, RouteConvertible {
        case mainTabBar
    }
    var scenePrefix: String = RouteSegment.mainTabBar.rawValue

    let store: Store<AppState>

    let navigationController = UINavigationController()

    var currentScene: AnyCoordinator?

    var rootViewController: UIViewController {
        return navigationController
    }

    init(store: Store<AppState>) {
        self.store = store
    }

    func start(route: Cordux.Route) {
        store.subscribe(self, RouteSubscription.init)
        changeScene(route)
    }

    func newState(_ state: RouteSubscription) {
        self.route = state.route
    }

    func changeScene(_ route: Cordux.Route) {
        guard let segment = RouteSegment(rawValue: route.first ?? "") else {
            return
        }

        let coordinator: AnyCoordinator
        switch segment {
        case .mainTabBar:
            coordinator = MainTabCoordinator(store: store)

        }

        scenePrefix = segment.rawValue

        coordinator.start(route: sceneRoute(route))
        currentScene = coordinator

    }
}
