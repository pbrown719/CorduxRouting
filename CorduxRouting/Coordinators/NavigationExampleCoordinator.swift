//
//  NavigationExampleCoordinator.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import UIKit
import Cordux

class NavigationExampleCoordinator: NavigationControllerCoordinator {

    let store: Store<AppState>

    var navigationController = UINavigationController()
    var rootViewController: UIViewController {
        return navigationController
    }

    init(_ store: Store<AppState>) {
        self.store = store
    }

    func start(route: Route) {
        let initialViewController = InitialViewController()
        initialViewController.corduxContext = Context(route, lifecycleDelegate: self)
        initialViewController.handler = self
        self.navigationController.setViewControllers([initialViewController], animated: false)
    }
}

extension NavigationExampleCoordinator {

    enum RouteSegment: String, RouteConvertible {
        case secondViewController
        case thirdViewController
        case modalViewController
    }


    func updateRoute(_ route: Cordux.Route) {

        guard let last = route.last else {
            return
        }

        let segment = Cordux.Route(last)
        let context = Context(segment, lifecycleDelegate: self)

        switch segment {
        case RouteSegment.secondViewController.route():
            showSecondViewController(context: context)
        case RouteSegment.thirdViewController.route():
            showThirdViewController(context: context)
        case RouteSegment.modalViewController.route():
            showModalViewController(context: context)
        default:
            fatalError("Case \(segment) unhandled in \(#function)")
        }
    }

    func showSecondViewController(context: Cordux.Context) {
        let secondViewController = SecondViewController()
        secondViewController.handler = self
        secondViewController.corduxContext = context
        navigationController.pushViewController(secondViewController, animated: true)
    }

    func showThirdViewController(context: Cordux.Context) {
        let thirdViewController = ThirdViewController()
        thirdViewController.corduxContext = context
        navigationController.pushViewController(thirdViewController, animated: true)
    }

    func showModalViewController(context: Cordux.Context) {
        let modalViewController = ModalViewController()
        modalViewController.handler = self
        modalViewController.corduxContext = context
        rootViewController.present(UINavigationController(rootViewController: modalViewController), animated: true, completion: nil)
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

// MARK: ViewControllerLifecycleDelegate
extension NavigationExampleCoordinator: ViewControllerLifecycleDelegate {

    @objc func viewWillAppear(_ viewController: UIViewController) {

        switch viewController {
        default:
            break
        }
    }

    @objc func viewWillDisappear(_ vc: UIViewController) {
        switch vc {
        default:
            return
        }
    }

    @objc func didMove(toParentViewController parentViewController: UIViewController?, viewController: UIViewController) {
        guard parentViewController == nil else {
            return
        }
        popRoute(viewController)
    }
}

extension NavigationExampleCoordinator: InitialViewControllerHandler {

    func nextPressed(controller: InitialViewController) {
        self.store.route(.push(RouteSegment.secondViewController))
    }

    func showModalPressed() {
        self.store.route(.push(RouteSegment.modalViewController))
    }
}

extension NavigationExampleCoordinator: SecondViewControllerHandler {

    func nextPressed(controller: SecondViewController) {
        self.store.route(.push(RouteSegment.thirdViewController))
    }
}


extension NavigationExampleCoordinator: ModalViewControllerHandler {

    func dismissModal() {
        rootViewController.dismiss(animated: true) {
            self.store.route(.pop(RouteSegment.modalViewController.route()))
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPressed))
    }

    func nextPressed() {

    }
}

