//
//  InfoViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 10.05.2023.
//

import UIKit

final class InfoViewController: UIViewController {

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("showAlert", for: .normal)
        button.setTitleColor(UIColor.yellow, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertButton)

        setupConstraints()
        alertButton.addTarget(self, action: #selector(alertButtonPressed(_:)), for: .touchUpInside)
    }

    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            alertButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 140.0),
            alertButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -140.0),
            alertButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor,constant: -240.0),
            alertButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }

    
    @objc func alertButtonPressed (_ sender: UIButton) {

        let alert = UIAlertController(title: "Alert", message: "Training to create alert", preferredStyle: .alert)

        alert.addAction(UIAlertAction(
            title: "Left", style: .default, handler: { _ in
            print("Left alert button pressed")
            }))
        alert.addAction(UIAlertAction(title: "Right", style: .destructive, handler: { _ in
            print("Right alert button pressed")
            }))

        self.present(alert, animated: true, completion: nil)
    }

}
