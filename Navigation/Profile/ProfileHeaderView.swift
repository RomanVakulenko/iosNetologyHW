//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Roman Vakulenko on 12.05.2023.
//

import UIKit

final class ProfileHeaderView: UIView {

    private let avatarHeight: CGFloat = 100
    lazy var avatarView: UIView = {
        let imageView = UIImageView(image: UIImage(named: "Colors"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = avatarHeight/2
        imageView.clipsToBounds = true
        (imageView.layer.borderWidth, imageView.layer.borderColor) = (3, UIColor.white.cgColor)
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.text = "Colors in iOS"
        return label
    }()
    lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 14)
        status.textColor = UIColor.gray
        return status
    }()
    lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "  Type new status"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor.black
        $0.backgroundColor = UIColor.white
        ($0.layer.borderWidth, $0.layer.borderColor) = (1, UIColor.black.cgColor)
        $0.layer.cornerRadius = 12
        return $0
    }(UITextField())
    lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 4
        $0.setTitle("Tap to set the new status", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        ($0.layer.shadowOffset.width, $0.layer.shadowOffset.height, $0.layer.shadowRadius) = (4, 4, 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7

        $0.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(textField)
        addSubview(setStatusButton)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func buttonPressed(_ sender: UIButton) {
        statusLabel.text = textField.text
    }

    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarView.widthAnchor.constraint(equalToConstant: avatarHeight),
            avatarView.heightAnchor.constraint(equalToConstant: avatarHeight),

            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -50),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            statusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 157),
            statusLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16+(avatarHeight/2)-20),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),

            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 157),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16+avatarHeight-40),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 40),

            setStatusButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: 0),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}
