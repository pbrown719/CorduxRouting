//
//  Reducer.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import Cordux

struct AppReducer: Reducer {

    func handleAction(_ action: Action, state: AppState) -> AppState {
        return AppState(route: state.route)
    }
}
