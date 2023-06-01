//
//  FeedViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

final class FeedViewController: UIViewController {

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.setTitle("Button 1", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.setTitle("Button 2", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.clipsToBounds = true

        buttonsStackView.axis = .vertical
//        buttonsStackView.distribution = .fill //without  - the same, because it's default
        buttonsStackView.alignment = .fill
        buttonsStackView.spacing = 10

        buttonsStackView.addArrangedSubview(firstButton)
        buttonsStackView.addArrangedSubview(secondButton)

        return buttonsStackView
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
        view.addSubview(stackView)
        setupConstraints()
        firstButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)

    }

    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
        ])
    }

    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.title = postObject.title
        postViewController.view.backgroundColor = .yellow

        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
