//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let postModel = ProfilePosts.createProfilePosts()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = #colorLiteral(red: 0.9495324492, green: 0.9487351775, blue: 0.9706708789, alpha: 1)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }

    //MARK: - private methods

    private func layout() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
        cell.setupCell(model: postModel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        header.backgroundColor = #colorLiteral(red: 0.9495324492, green: 0.9487351775, blue: 0.9706708789, alpha: 1)
        return header
    }
} 
