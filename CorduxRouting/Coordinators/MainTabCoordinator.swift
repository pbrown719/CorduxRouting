//
//  MainTabCoordinator.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import Cordux

class MainTabCoordinator: NSObject, TabBarControllerCoordinator, SubscriberType {
    let store: Store<AppState>

    let scenes: [Scene]
    let tabBarController: UITabBarController = UITabBarController()

    init(store: Store<AppState>) {
        self.store = store

        scenes = [
            Scene(prefix: "navigationExample", coordinator: NavigationExampleCoordinator(store)),
            Scene(prefix: "tabSwitchingExample", coordinator: ActionCoordinator(store))
        ]
    }

    func start(route: Cordux.Route) {
        tabBarController.delegate = self
        scenes.forEach { $0.coordinator.start(route: route) }
        tabBarController.viewControllers = scenes.map { $0.coordinator.rootViewController }
        store.setRoute(.push(scenes[tabBarController.selectedIndex]))

        store.subscribe(self, RouteSubscription.init)
    }

    func newState(_ state: RouteSubscription) {
        self.route = state.route
    }
}

extension MainTabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return setRouteForViewController(viewController)
    }
}
