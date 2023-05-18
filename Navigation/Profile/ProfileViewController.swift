//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    private lazy var button: UIButton = {
        button = UIButton(frame: CGRect(x: 16, y: profileHeaderView.frame.origin.y+2*16+100, width: profileHeaderView.frame.width-32, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        (button.layer.shadowOffset.width, button.layer.shadowOffset.height, button.layer.shadowRadius) = (4, 4, 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7

        return button
    }()

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame//к моменту отрисовки subview размеры superView будут корректны (потому тут, а не в ДидЛоад)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }

    @objc func buttonPressed(_ sender: UIButton) {
        profileHeaderView.statusLabel?.text = profileHeaderView.statusText
    }
}
