//
//  PostViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 10.05.2023.
//

import UIKit

final class PostViewController: UIViewController {

    override func viewDidLoad() { 
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More info",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
    }

    @objc func rightHandAction() {
        let infoViewController = InfoViewController()
        infoViewController.view.backgroundColor = .green
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .popover

        present(infoViewController, animated: true)

    }
}
