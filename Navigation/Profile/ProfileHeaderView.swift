//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Roman Vakulenko on 12.05.2023.
//

import UIKit

class ProfileHeaderView: UIView {

    let avatarView: UIView
    let labelView: UILabel

    override init(frame: CGRect) {
        avatarView = UIView()
        labelView = UILabel()
        super.init(frame: frame)
        addSubview(avatarView)
        addSubview(labelView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setAvatar()
        setLabel()
    }

    private func setAvatar() {
        let imageView = UIImageView(image: UIImage(named: "Colors"))
        imageView.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.clipsToBounds = true
        (imageView.layer.borderWidth, imageView.layer.borderColor) = (3, UIColor.white.cgColor)
        avatarView.addSubview(imageView)
    }

    private func setLabel() {
        let label = UILabel(frame: CGRect(x: self.center.x-50, y: 27, width: 200, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.text = "Colors in iOS"
        labelView.addSubview(label)
    }

}
