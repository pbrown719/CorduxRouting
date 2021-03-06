//
//  ViewControllers.swift
//  CorduxRouting
//
//  Created by Preston Brown on 3/22/17.
//  Copyright © 2017 Preston Brown. All rights reserved.
//

import UIKit


protocol CenterLabelDisplayable: class {}

extension CenterLabelDisplayable where Self: UIViewController {

    func addLabel(with text: String) {
        let textLabel = UILabel(frame: CGRect(x: 50, y: 200, width: view.frame.size.width-100, height: 200))
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.text = text
        view.addSubview(textLabel)
    }
}


class ViewController: UIViewController, CenterLabelDisplayable {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPressed))
    }

    func nextPressed() {
        // Subclasses override
    }
}

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
        self.addLabel(with: "Press \"Next\"")
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
        self.addLabel(with: "Press \"Next\" Again")
    }

    override func nextPressed() {
        handler?.nextPressed(controller: self)
    }
}

class ThirdViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Third VC"
        view.backgroundColor = .green
        navigationItem.rightBarButtonItem = nil
        self.addLabel(with: "Now repeatedly press \"back\" until you land on the initial controller and the modal is presented.")
    }
}


protocol ModalViewControllerHandler: class {
    func dismissModal()
}

class ModalViewController: UIViewController, CenterLabelDisplayable {
    weak var handler: ModalViewControllerHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissPressed))
        self.addLabel(with: "Dismiss this modal")
    }

    func dismissPressed() {
        handler?.dismissModal()
    }
}

protocol ActionViewControllerHandler: class {
    func actionPressed()
}

class ActionViewController: UIViewController, CenterLabelDisplayable {
    weak var handler: ActionViewControllerHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Action VC"
        view.backgroundColor = .purple
        self.addLabel(with: "Press the action button, switch to the other tab and navigate. After it finishes executing it puts our route in a weird state, causing us to jump back to this view.")

        addButton()
    }

    func addButton() {
        let button = UIButton(frame: CGRect(x: 50, y: view.frame.size.height-200, width: view.frame.size.width-100, height: 100))
        button.backgroundColor = .orange
        button.setTitle("Action Button", for: .normal)
        button.addTarget(self, action: #selector(ActionViewController.buttonPressed), for: .touchUpInside)
        view.addSubview(button)
    }

    func buttonPressed() {
        handler?.actionPressed()
    }
}
