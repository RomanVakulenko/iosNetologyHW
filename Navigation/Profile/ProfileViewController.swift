//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {

//Создайте экземпляр класса ProfileHeaderView в классе ProfileViewController, добавьте его в качестве subview и в методе viewWillLayoutSubviews() задайте ему frame, равный frame корневого view.
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray

        view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = self.view.frame
    }


}
