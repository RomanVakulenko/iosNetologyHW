//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileHeaderViewLayout()
    }

    private func profileHeaderViewLayout() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileHeaderView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220.0)
        ])
    }
}
