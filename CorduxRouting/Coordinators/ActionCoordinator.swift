//
//  ActionCoordinator.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import Foundation
import UIKit
import Cordux

class ActionCoordinator: NavigationControllerCoordinator {
    let store: Store<AppState>

    var navigationController = UINavigationController()
    var rootViewController: UIViewController {
        return navigationController
    }

    init(_ store: Store<AppState>) {
        self.store = store
    }

    func start(route: Route) {
        let mainViewController = UIViewController()
        mainViewController.view.backgroundColor = .purple
        mainViewController.title = "Right VC"
        self.navigationController.setViewControllers([mainViewController], animated: false)
    }
}

extension ActionCoordinator {

    enum RouteSegment: String, RouteConvertible {
        case secondViewController
        case thirdViewController
        case modalViewController
    }

    func updateRoute(_ route: Cordux.Route) {

    }

    func parse(_ route: Cordux.Route) -> [RouteSegment] {
        return route.flatMap { RouteSegment.init(rawValue: $0) }
    }

    func popRoute(_ viewController: UIViewController, completion: (()->())? = nil) {
        guard let context = viewController.corduxContext  else {
            return
        }
        store.route(.pop(context.routeSegment.route()))
    }
}
