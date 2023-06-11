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
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
//        table.estimatedSectionHeaderHeight = 0 //отключить предварительную оценку высоты заголовков секций, чтобы улучшить производительность таблицы.
//        table.sectionHeaderHeight = UITableView.automaticDimension
//        table.contentInsetAdjustmentBehavior = .never
//        table.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0);
        return table
    }()

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
//        tableView.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
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

        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        header.backgroundColor = .systemGray5
        return header
    }
} 
