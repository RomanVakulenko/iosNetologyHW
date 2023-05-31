//
//  LogInViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 31.05.2023.
//

import UIKit

final class LogInViewController: UIViewController {

    private let loginModel = LogInModel.makeMockModel()

    private lazy var logoView: UIView = {
        let image = UIImageView(image: UIImage(named: "vkLogo"))
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellIdentifier)
        return table
    }()

//    private lazy var buttonView: UIButton = {
//        let logInButton = UIButton()
//        logInButton.backgroundColor = UIColor(hex: 0x4885CC)
//        logInButton.layer.cornerRadius = 10
//        logInButton.titleLabel?.text = "Log in"
//        return logInButton
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        [logoView, tableView].forEach { view.addSubview($0) }
        view.addSubview(tableView)
        view.addSubview(logoView)
//        view.addSubview(buttonView)
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    private func layout(){
        let safearea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: safearea.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: safearea.topAnchor, constant: 120),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),

            tableView.centerXAnchor.constraint(equalTo: safearea.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            tableView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 100),

//            buttonView.centerXAnchor.constraint(equalTo: safearea.centerXAnchor),
//            buttonView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
//            buttonView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor, constant: 16),
//            buttonView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor, constant: -16),
//            buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

extension LogInViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        loginModel.count
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("can not dequeue ReusableCell")
        }
//        cell.
        return cell
//        UITableViewCell()
    }
}
