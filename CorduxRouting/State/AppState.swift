//
//  AppState.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import Cordux

struct RouteSubscription {
    let route: Cordux.Route

    init(_ state: AppState) {
        route = state.route
    }
}


struct AppState: StateType {
    var route: Cordux.Route = [] {
        didSet {
            print("Current Route: \(route)")
        }
    }

    
}
