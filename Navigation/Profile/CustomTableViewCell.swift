//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 31.05.2023.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    private let contentWhiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        return whiteView
    }()

    private let logInTextFieldView: UITextField = {
        let logInText = UITextField()
        logInText.translatesAutoresizingMaskIntoConstraints = false
        logInText.placeholder = "  Email or phone"
        logInText.textColor = .black
        logInText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        logInText.tintColor = .lightGray
        logInText.autocapitalizationType = .none
        return logInText
    }()

    private let passwordTextFieldView: UITextField = {
        let passwordText = UITextField()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.placeholder = "  Password"
        passwordText.textColor = .black
        passwordText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        passwordText.tintColor = .lightGray
        passwordText.autocapitalizationType = .none
        return passwordText
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        customizeCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeCell(){
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray6
    }

//    func setupCell(_ model: LogInModel){
//        logInTextFieldView.text = model.loginText
//        passwordTextFieldView.text = model.passwordText
//    }

    private func layout(){
        [logInTextFieldView, passwordTextFieldView].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([

//            contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 95),

            logInTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logInTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logInTextFieldView.topAnchor.constraint(equalTo: contentView.topAnchor),
            logInTextFieldView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 50),

            passwordTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordTextFieldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 50),
        ])

    }
                                                               

}
