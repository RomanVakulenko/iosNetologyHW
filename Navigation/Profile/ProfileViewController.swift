//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let postModel = ProfilePosts.createProfilePosts()
    private let gallery = GalleryModel.createMockModel()
    private let header = ProfileHeaderView()

    private var avatarLeading = NSLayoutConstraint()
    private var avatarTrailing = NSLayoutConstraint()
    private var avatarWidth = NSLayoutConstraint()
    private var avatarCenterY = NSLayoutConstraint()
    private var avatarConstraints = [NSLayoutConstraint]()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var baseplateForExpandedAvatar: UIView = {
        let opacityView = UIView()
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.backgroundColor = .black
        opacityView.alpha = 0.0
        return opacityView
    }()

    private lazy var buttonForCloseExpandedAvatar: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(closeFullScreenAvatar(_:)), for: .touchUpInside)
        return button
    }()

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(baseplateForExpandedAvatar)
        baseplateForExpandedAvatar.addSubview(buttonForCloseExpandedAvatar)
//        header.addSubview(header.avatarView)
        view.backgroundColor =  #colorLiteral(red: 0.9495324492, green: 0.9487351775, blue: 0.9706708789, alpha: 1)
        print("1=====================View did load")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
        print("2-----View will layout subviews-----------------------")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGesture()
        print("3-------______________________________========View did appear")
    }

    //MARK: - private methods
    private func layout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            baseplateForExpandedAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseplateForExpandedAvatar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseplateForExpandedAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseplateForExpandedAvatar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            header.avatarView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            header.avatarView.topAnchor.constraint(equalTo: header.topAnchor, constant: 16),
            header.avatarView.widthAnchor.constraint(equalToConstant: 100),
            header.avatarView.heightAnchor.constraint(equalToConstant: 100),

            buttonForCloseExpandedAvatar.trailingAnchor.constraint(equalTo: baseplateForExpandedAvatar.trailingAnchor, constant: -8),
            buttonForCloseExpandedAvatar.topAnchor.constraint(equalTo: baseplateForExpandedAvatar.topAnchor, constant: 8),
            buttonForCloseExpandedAvatar.widthAnchor.constraint(equalToConstant: 20),
            buttonForCloseExpandedAvatar.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    private func setUpExpandedAvatarConstraints(){
        avatarConstraints = [
            header.avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.avatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.avatarView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            header.avatarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            header.avatarView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(avatarConstraints)
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expandAvatar))
        header.avatarView.addGestureRecognizer(tapGesture)
        header.avatarView.isUserInteractionEnabled = true
    }

    @objc func expandAvatar() {
        print("4----------------------Avatar view tapped")
        UIView.animateKeyframes(withDuration: 0.8, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) { [weak self] in
                guard let self else {return}
                view.addSubview(header.avatarView)
                self.setUpExpandedAvatarConstraints()
                self.header.avatarView.layer.cornerRadius = 0
                self.header.avatarView.layer.borderWidth = 0

                self.baseplateForExpandedAvatar.alpha = 0.5
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) { [weak self] in
                guard let self else {return}
                self.buttonForCloseExpandedAvatar.alpha = 0.5
            }
        }
    }

    @objc func closeFullScreenAvatar(_ sender: UIButton) {
        print("5-------------------Button for close expanded avatar tapped")
        UIView.animateKeyframes(withDuration: 0.8, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) { [weak self] in
                guard let self else {return}
                self.buttonForCloseExpandedAvatar.alpha = 0.0
                self.avatarConstraints.forEach { $0.isActive = false }
                header.avatarView.removeFromSuperview()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.5) { [weak self] in
                guard let self else {return}
                header.addSubview(header.avatarView)
                self.header.avatarView.layer.cornerRadius = 50
                self.header.avatarView.layer.borderWidth = 3

                self.baseplateForExpandedAvatar.alpha = 0.0
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return postModel.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell

            photosCell.setupPhotoForTableCell(model: gallery[indexPath.row])
            photosCell.selectionStyle = .none
            return photosCell

        case 1:
            guard let cellForPosts = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}

            cellForPosts.setupCell(model: postModel[indexPath.row])
            cellForPosts.selectionStyle = .none
            return cellForPosts

        default: return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            header.backgroundColor =  #colorLiteral(red: 0.9495324492, green: 0.9487351775, blue: 0.9706708789, alpha: 1)
            return header
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return .leastNonzeroMagnitude
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let galleryVC = GallaryCollectionViewController()
        navigationController?.pushViewController(galleryVC, animated: true)
    }
}


