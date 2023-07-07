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
        let imageView = UIImageView(image: UIImage(named: "Simba"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = avatarHeight/2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        (imageView.layer.borderWidth, imageView.layer.borderColor) = (3, UIColor.white.cgColor)
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.text = "Simba - the cat"
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 14)
        status.textColor = UIColor.gray
        return status
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = "Type new status"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        (textField.layer.borderWidth, textField.layer.borderColor) = (1, UIColor.black.cgColor)
        textField.layer.cornerRadius = 12
        textField.delegate = self
        return textField
    }()

    private lazy var setStatusButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Tap to set the new status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        (button.layer.shadowOffset.width, button.layer.shadowOffset.height, button.layer.shadowRadius) = (4, 4, 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        [avatarView, nameLabel, statusLabel, textField, setStatusButton].forEach { self.addSubview($0) }
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    При нажатии на кнопку Set status необходимо реализовать проверку на пустой UITextFiled с установкой статуса, по аналогии с логинкой.
    @objc func buttonPressed(_ sender: UIButton) {

        if !textField.hasText {
            textField.shake6 {
                UIView.animateKeyframes(withDuration: 1, delay: 0) { [weak self] in
                    guard let self else {return}
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.01) {
//                        self.textField.text? += "Type new status HERE!"
//                        self.textField.textColor = .red
                        self.textField.attributedPlaceholder = NSAttributedString(
                                string: "Type new status HERE!",
                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.99) {
                        self.textField.attributedPlaceholder = NSAttributedString(
                            string: "Type new status HERE!",
                            attributes: [NSAttributedString.Key.foregroundColor : UIColor.red.withAlphaComponent(0.6)])

                    }
                }
            }
        } else if textField.hasText {
            statusLabel.text = textField.text
        }
        if statusLabel.text != "Waiting for something..." {
            self.textField.text = nil
            self.textField.attributedPlaceholder = NSAttributedString(
                string: "Type new status",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.5)])
        }
        textFieldShouldReturn(textField) //textField перестает быть первым откликающимся
    }



    func setUpConstraints(){
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarView.widthAnchor.constraint(equalToConstant: avatarHeight),
            avatarView.heightAnchor.constraint(equalToConstant: avatarHeight),
            
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 157),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            statusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 157),
            statusLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16+(avatarHeight/2)-20),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),

            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 157),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16+avatarHeight-40),
            textField.heightAnchor.constraint(equalToConstant: 40),

            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            setStatusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //textField перестает быть первым откликающимся
        return true
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

    func shake2(count: Float = 6, for duration: TimeInterval = 0.5, withTranslation translation: Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }

    func shake3(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        layer.add(animation, forKey: "position")
    }

    func shake4(view: UIView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 1
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        propertyAnimator.addAnimations({
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        propertyAnimator.addCompletion { (_) in
            view.layer.borderWidth = 0
        }
        propertyAnimator.startAnimation()
    }

    func shake5(completion: (() -> Void)? = nil) {
        let speed = 0.75
        let time = 1.0 * speed - 0.15
        let timeFactor = CGFloat(time / 4)
        let animationDelays = [timeFactor, timeFactor * 2, timeFactor * 3]

        let shakeAnimator = UIViewPropertyAnimator(duration: time, dampingRatio: 0.3)
        // left, right, left, center
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 10, y: 0)
        })
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: -10, y: 0)
        }, delayFactor: animationDelays[0])
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 10, y: 0)
        }, delayFactor: animationDelays[1])
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: animationDelays[2])
        shakeAnimator.startAnimation()

        shakeAnimator.addCompletion { _ in
            completion?()
        }

        shakeAnimator.startAnimation()
    }

    func shake6(duration: CGFloat = 0.15, repeatCount: Float = 3, angle: Float = Float.pi / 40, completion: (() -> Void)? = nil) {
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.duration = TimeInterval(duration/CGFloat(repeatCount))
        rotationAnimation.repeatCount = repeatCount
        rotationAnimation.autoreverses = true
        rotationAnimation.fromValue = -angle
        rotationAnimation.toValue = angle
        rotationAnimation.isRemovedOnCompletion = true

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            if let completion = completion {
                completion()
            }
        }
        layer.add(rotationAnimation, forKey: "shakeAnimation")
        CATransaction.commit()
    }
}
