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
        return table
    }()

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
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
        postModel.count
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
        if section == 0 {
            return header
        } else {
            return nil
        }
    }
} 

//Ранее созданный массив с публикациями используйте в качестве источника данных для таблицы.
//Используйте ProfileTableHederView в качестве HeaderForSection для нулевой секции.
//Создайте файл PostTableViewCell.swift и добавьте в него класс UITableViewCell с именем PostTableViewCell.
//Реализуйте верстку в только что созданном классе согласно макету Lesson_6_Layout_3. Используйте Auto Layout.
//Используйте созданную ячейку для отображения контента публикации.
