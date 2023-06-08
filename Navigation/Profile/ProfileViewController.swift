//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    var postsArray: [ProfilePosts] = []

    private func createProfilePosts() {
        for _ in 0...3 {
            postsArray.append(ProfilePosts(author: "cat", description: "Bengal", image: "Bengal", likes: 3, views: 5))
            postsArray.append(ProfilePosts(author: "dog", description: "For terrier", image: "FoxTerrier", likes: 2, views: 9))
            postsArray.append(ProfilePosts(author: "mouse", description: "Jerry", image: "Jerry", likes: 1, views: 3))
            postsArray.append(ProfilePosts(author: "cat2", description: "Tom", image: "Tom", likes: 5, views: 2))
        }
    }

//Merge Pull request and after make new branch and do: ...вроде как ниже надо все удалить

    let profileHeaderView = ProfileHeaderView()

    private lazy var bottomButton: UIButton = {
        let tapButton = UIButton()
        tapButton.setTitle("Кнопка", for: .normal)
        tapButton.backgroundColor = .systemBlue
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        return tapButton
    }()

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(bottomButton)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutForProfileAndButton()
    }

    private func layoutForProfileAndButton() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileHeaderView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220.0),

            bottomButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 50),
            bottomButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
}
