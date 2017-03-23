//
//  Reducer.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import Cordux

enum TestAction: Action {
    case longDurationAction
}


struct AppReducer: Reducer {

    func handleAction(_ action: Action, state: AppState) -> AppState {

        if let _ = action as? TestAction {
            print("Here's your action")
            for _ in 0...1000000000 {

            }
        }

        print("New State")
        return AppState(route: state.route)
    }
}
