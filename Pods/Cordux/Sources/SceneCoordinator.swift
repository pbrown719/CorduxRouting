//
//  SceneCoordinator.swift
//  Cordux
//
//  Created by Ian Terrell on 7/28/16.
//  Copyright © 2016 WillowTree. All rights reserved.
//

import UIKit

public protocol SceneCoordinator: Coordinator {
    var scenePrefix: String { get }
    var currentScene: AnyCoordinator? { get }
    func changeScene(_ route: Route)
    func sceneRoute(_ route: Route) -> Route
}

public extension SceneCoordinator {
    public var route: Route {
        get {
            let route: Route = scenePrefix.route()
            return route + (currentScene?.route ?? [])
        }
        set {
            let r = route
            if r.first != newValue.first {
                changeScene(newValue)
            }
            routeScene(newValue)
        }
    }

    public func routeScene(_ route: Route) {
        currentScene?.route = sceneRoute(route)
    }

    public func sceneRoute(_ route: Route) -> Route {
        return Route(route.dropFirst())
    }
}
