//
//  FeedViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("step to post", for: .normal)
        return button
    }()

    let postObject: Post
    init(post: Post) {
        self.postObject = post
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
           self.init(coder: aDecoder)
       }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(actionButton)

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
            ),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])

        actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }


    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.title = postObject.title
        postViewController.view.backgroundColor = .yellow

        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}
