//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Roman Vakulenko on 12.05.2023.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var avatarView: UIView = {
        let imageView = UIImageView(image: UIImage(named: "Colors"))
        imageView.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.clipsToBounds = true
        (imageView.layer.borderWidth, imageView.layer.borderColor) = (3, UIColor.white.cgColor)
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: self.center.x-50, y: 18, width: 200, height: 20)//когда 27 top - некрасиво
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.text = "Colors in iOS"
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let status = UILabel(frame: CGRect(x: 157, y: 16+(100/2)-20, width: 200, height: 20))
        status.text = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 14)
        status.textColor = UIColor.gray
        return status
    }()
    private lazy var textField: UITextField = {
        let statusChangingTextField = UITextField(frame: CGRect(x: 156, y: 16+100-40, width: 200, height: 40))
        statusChangingTextField.placeholder = "  Type new status"
        statusChangingTextField.font = UIFont.systemFont(ofSize: 15)
        statusChangingTextField.textColor = UIColor.black
        statusChangingTextField.backgroundColor = UIColor.white
        (statusChangingTextField.layer.borderWidth, statusChangingTextField.layer.borderColor) = (1, UIColor.black.cgColor)
        statusChangingTextField.layer.cornerRadius = 12
        return statusChangingTextField
    }()
    private lazy var button: UIButton = {
        button = UIButton(frame: CGRect(x: 16, y: 2*16+100, width: self.frame.width-32, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        (button.layer.shadowOffset.width, button.layer.shadowOffset.height, button.layer.shadowRadius) = (4, 4, 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(textField)
        addSubview(button)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }

    @objc func buttonPressed(_ sender: UIButton) {
        statusLabel.text = textField.text
    }

}
