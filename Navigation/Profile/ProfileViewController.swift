//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileHeaderView.frame = view.safeAreaLayoutGuide.layoutFrame//к моменту отрисовки subview размеры superView будут корректны (потому тут, а не в ДидЛоад)
    }
}
