//
//  LogInViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 31.05.2023.
//

import UIKit

final class LogInViewController: UIViewController {

    private lazy var logoView: UIView = {
        let image = UIImageView(image: UIImage(named: "vkLogo"))
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let textAlignment: CGFloat = 12
    private lazy var logInTextFieldView: UITextField = {
        let logInText = UITextField()
        logInText.translatesAutoresizingMaskIntoConstraints = false
        logInText.placeholder = "  Email or phone"
        logInText.layer.sublayerTransform = CATransform3DMakeTranslation(textAlignment, 0, 0)
        logInText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        logInText.tintColor = .lightGray
        logInText.autocapitalizationType = .none
        return logInText
    }()

    private lazy var passwordTextFieldView: UITextField = {
        let passwordText = UITextField()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.placeholder = "  Password"
        passwordText.layer.sublayerTransform = CATransform3DMakeTranslation(textAlignment, 0, 0)
        passwordText.textColor = .black
        passwordText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        passwordText.tintColor = .lightGray
        passwordText.autocapitalizationType = .none
        return passwordText
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 0
        [logInTextFieldView, passwordTextFieldView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    private lazy var buttonView: UIButton = {
        let logInButton = UIButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.backgroundColor = UIColor(hex: 0x4885CC)
        logInButton.layer.cornerRadius = 10
        logInButton.setTitle("Log in", for: .normal)
        logInButton.addTarget(self, action: #selector(logInPressed(_:)), for: .touchUpInside)
        return logInButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [logoView, stackView, buttonView].forEach { view.addSubview($0) }
        layout()
        customizeStackView()
    }

    override func viewWillLayoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: -textAlignment, y: logInTextFieldView.frame.height-1.0, width: logInTextFieldView.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        logInTextFieldView.borderStyle = .none
        logInTextFieldView.layer.addSublayer(bottomLine)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    private func customizeStackView(){
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
    }

    @objc func logInPressed(_ sender: UIButton){
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }

    private func layout(){
        let safearea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: safearea.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: safearea.topAnchor, constant: 120),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),

            stackView.centerXAnchor.constraint(equalTo: safearea.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            logInTextFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInTextFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInTextFieldView.topAnchor.constraint(equalTo: stackView.topAnchor),
            logInTextFieldView.heightAnchor.constraint(equalToConstant: 50),

            passwordTextFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            passwordTextFieldView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 50),

            buttonView.centerXAnchor.constraint(equalTo: safearea.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

