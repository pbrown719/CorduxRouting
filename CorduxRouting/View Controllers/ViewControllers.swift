//
//  ViewControllers.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import UIKit


protocol InitialViewControllerHandler: class {
    func nextPressed(controller: InitialViewController)
    func showModalPressed()
}

class InitialViewController: ViewController {
    weak var handler: InitialViewControllerHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Initial VC"
        view.backgroundColor = .blue

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Modal", style: .plain, target: self, action: #selector(showModal))
    }

    override func nextPressed() {
        handler?.nextPressed(controller: self)
    }

    func showModal() {
        handler?.showModalPressed()
    }
}

protocol SecondViewControllerHandler: class {
    func nextPressed(controller: SecondViewController)
}

class SecondViewController: ViewController {
    weak var handler: SecondViewControllerHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Second VC"
        view.backgroundColor = .red
    }

    override func nextPressed() {
        handler?.nextPressed(controller: self)
    }
}

protocol ThirdViewControllerHandler: class {
    func nextPressed(controller: ThirdViewController)
}

class ThirdViewController: ViewController {
    weak var handler: ThirdViewControllerHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Third VC"
        view.backgroundColor = .green
        navigationItem.rightBarButtonItem = nil
    }
}


protocol ModalViewControllerHandler: class {
    func dismissModal()
}

class ModalViewController: UIViewController {
    weak var handler: ModalViewControllerHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissPressed))
    }

    func dismissPressed() {
        handler?.dismissModal()
    }
}
