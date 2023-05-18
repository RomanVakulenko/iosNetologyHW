//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Roman Vakulenko on 12.05.2023.
//

import UIKit

class ProfileHeaderView: UIView {

    let avatarView: UIView?
    let nameLabel: UILabel?
    let statusLabel: UILabel?
    var textField: UITextField?
    let button: UIButton?

    var statusText: String?

    override init(frame: CGRect) {
        avatarView = UIView()
        nameLabel = UILabel()
        statusLabel = UILabel()
        textField = UITextField()
        button = UIButton()
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setAvatar()
        setNameLabel()
        setStatusLabel()
        setStatusChangingTextField()
        showStatusButton()
    }

    let imageView = UIImageView(image: UIImage(named: "Colors"))
    private func setAvatar() {
        imageView.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.clipsToBounds = true
        (imageView.layer.borderWidth, imageView.layer.borderColor) = (3, UIColor.white.cgColor)
        addSubview(imageView)
    }

    let label = UILabel()
    private func setNameLabel() {
        label.frame = CGRect(x: self.center.x-50, y: 18, width: 200, height: 20)//когда 27 top - некрасиво
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.text = "Colors in iOS"
        addSubview(label)
    }

    private func setStatusLabel() {
        let status = UILabel(frame: CGRect(x: self.center.x-50, y: 16+(100/2)-20, width: 200, height: 20))
        status.text = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 14)
        status.textColor = .gray
        addSubview(status)
    }

    let statusChangingTextField = UITextField(frame: CGRect(x: 157, y: 16+100-40, width: 200, height: 40))
    func setStatusChangingTextField() {
        statusChangingTextField.placeholder = "  Type new status"
        statusChangingTextField.font = UIFont.systemFont(ofSize: 15)
        statusChangingTextField.textColor = UIColor.black
        statusChangingTextField.backgroundColor = UIColor.white
        (statusChangingTextField.layer.borderWidth, statusChangingTextField.layer.borderColor) = (1, UIColor.black.cgColor)
        statusChangingTextField.layer.cornerRadius = 12
        addSubview(statusChangingTextField)

        statusChangingTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: UIControl.Event.editingChanged)
        }

    @objc func statusTextChanged(_ sender: UITextField) {
        guard let newStatusText = statusChangingTextField.text else { return }
        statusText = newStatusText
    }

    func showStatusButton() {
        let button = UIButton(frame: CGRect(x: 16, y: 2*16+100, width: self.frame.width-32, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        (button.layer.shadowOffset.width, button.layer.shadowOffset.height, button.layer.shadowRadius) = (4, 4, 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        addSubview(button)

        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)

    }

    @objc func buttonPressed(_ sender: UIButton) {
        statusLabel?.text = statusText
    }
}
