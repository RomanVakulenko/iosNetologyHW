//
//  LogInViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 31.05.2023.
//

import UIKit

final class LogInViewController: UIViewController {

    //MARK: - properties

    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        return contentView
    }()

    private lazy var logoView: UIView = {
        let image = UIImageView(image: UIImage(named: "vkLogo"))
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var logInTextFieldView: UITextField = { [unowned self] in
        let logInText = UITextField()
        logInText.translatesAutoresizingMaskIntoConstraints = false
        logInText.autocorrectionType = .no
        logInText.keyboardType = .default
        logInText.returnKeyType = .done
        logInText.clearButtonMode = .whileEditing
        logInText.contentVerticalAlignment = .center
        logInText.placeholder = "  Email or phone"
        logInText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        logInText.tintColor = .lightGray
        logInText.backgroundColor = .systemGray6
        logInText.autocapitalizationType = .none
        logInText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: logInText.frame.height))
        logInText.leftViewMode = .always
        logInText.heightAnchor.constraint(equalToConstant: 49.5).isActive = true
        return logInText
    }()

    private lazy var lineBetweenTextFields: UIView = {
        let lineBetween = UIView()
        lineBetween.translatesAutoresizingMaskIntoConstraints = false
        lineBetween.backgroundColor = UIColor.lightGray
        lineBetween.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return lineBetween
    }()

    private lazy var passwordTextFieldView: UITextField = { [unowned self] in
        let passwordText = UITextField()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.autocorrectionType = .no
        passwordText.keyboardType = .default
        passwordText.returnKeyType = .done
        passwordText.clearButtonMode = .whileEditing
        passwordText.contentVerticalAlignment = .center
        passwordText.placeholder = "  Password"
        passwordText.textColor = .black
        passwordText.isSecureTextEntry = true
        passwordText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        passwordText.tintColor = .lightGray
        passwordText.backgroundColor = .systemGray6
        passwordText.autocapitalizationType = .none
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordText.frame.height))
        passwordText.leftViewMode = .always
        passwordText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return passwordText
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        [logInTextFieldView, lineBetweenTextFields, passwordTextFieldView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    private lazy var passwordWarningLabel: UILabel = {
        let warningLabel = UILabel()
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.textColor = .red
        warningLabel.text = "  Password has 5 or more characters"
        warningLabel.font = .systemFont(ofSize: 15)
        warningLabel.layer.opacity = 0
        return warningLabel
    }()

    private lazy var buttonView: UIButton = { [unowned self] in
        let logInButton = UIButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        //        logInButton.backgroundColor = UIColor(hex: 0x4885CC)
        if let colorFromFile = UIImage(named: "blue_pixel") {
            logInButton.backgroundColor = UIColor(patternImage: colorFromFile)
        }
        logInButton.titleLabel?.textColor = .white
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.setTitle("Log in", for: .normal)
        logInButton.addTarget(self, action: #selector(logInPressed(_:)), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        logInButton.addTarget(self, action: #selector(buttonUnhighlighted), for: .touchUpInside)
        return logInButton
    }()

    private lazy var portraitConstraints: [NSLayoutConstraint] = {
        [//base constrains
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        //constrains of content
        logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        logoView.topAnchor.constraint(equalTo: contentView.topAnchor), //есть ниже отдельный
        logoView.widthAnchor.constraint(equalToConstant: 100),
        logoView.heightAnchor.constraint(equalToConstant: 100),

        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        stackView.heightAnchor.constraint(equalToConstant: 100),

        passwordWarningLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
        passwordWarningLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),

        buttonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        buttonView.topAnchor.constraint(equalTo: passwordWarningLabel.bottomAnchor, constant: 24),
        buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        buttonView.heightAnchor.constraint(equalToConstant: 50),
        buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //constrains of stack doesn't need cause of alignment & distribution properties, also we set heights at elements'
        ]
    }()

    private lazy var landscapeConstraints: [NSLayoutConstraint] = {
        [//base constrains
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        //constrains of content
        logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        logoView.topAnchor.constraint(equalTo: contentView.topAnchor),
        logoView.widthAnchor.constraint(equalToConstant: 100),
        logoView.heightAnchor.constraint(equalToConstant: 100),

        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50),
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        stackView.heightAnchor.constraint(equalToConstant: 100),

        passwordWarningLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
        passwordWarningLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),

        buttonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        buttonView.topAnchor.constraint(equalTo: passwordWarningLabel.bottomAnchor, constant: 24),
        buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        buttonView.heightAnchor.constraint(equalToConstant: 50),
        buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //constrains of stack doesn't need cause of alignment & distribution properties, also we set heights at elements' initialization
        ]
    }()

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()

        logInTextFieldView.delegate = self
        passwordTextFieldView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        changeConstraints()
        traitCollection.verticalSizeClass == .regular ? usePortraitConstraints() : useLandscapeConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { //apple рекомендует
        super.traitCollectionDidChange(previousTraitCollection)
        if UITraitCollection.current.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        } else if UITraitCollection.current.verticalSizeClass == .compact {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
//        view.setNeedsLayout() //не обязателен, перерисовка произойдет автоматически после изменения ограничений. Может быть полезен, если хотим отложить перерисовку до более подходящего момента, тогда надо вызвать метод setNeedsLayout() в другом месте кода, когда это будет нужно
    }
    //MARK: - private methods

    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoView, stackView, passwordWarningLabel, buttonView].forEach { contentView.addSubview($0) }
    }

    private func usePortraitConstraints() {
        NSLayoutConstraint.activate(portraitConstraints)
    }
    private func useLandscapeConstraints() {
        NSLayoutConstraint.activate(landscapeConstraints)
    }

//    private func changeConstraints() { //рабочий код
//        let isPortrait = view.frame.size.height > view.frame.size.width
//        NSLayoutConstraint.deactivate(portraitConstraints + landscapeConstraints)
//        isPortrait ? usePortraitConstraints() : useLandscapeConstraints()
//    }
    private func changeConstraints() { //рабочий код
        if UIDevice.current.orientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            usePortraitConstraints()
        } else if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            useLandscapeConstraints()
        }
    }

    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func willShowKeyboard(_ notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        if scrollView.contentInset.bottom < keyboardHeight {
            scrollView.contentInset.bottom += keyboardHeight
//            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)//сдвигает вертикальный скролл индикатор на высоту клавиатуры
            scrollView.scrollRectToVisible(buttonView.frame, animated: true)
        }
    }

    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
//        scrollView.verticalScrollIndicatorInsets = .zero// return it's default height
    }

    @objc func buttonHighlighted() {
        buttonView.alpha = 0.8
    }

    @objc func buttonUnhighlighted() {
        buttonView.alpha = 1.0
    }


    private func isEmpty(loginTextField loginField: UITextField, passwordTextField passwordField: UITextField, passwordWarning: UILabel, _ sender: UIButton) {

        if (loginField.text?.isEmpty ?? true) && (passwordField.text?.isEmpty ?? true) {
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self else { return }
                loginField.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3)
                passwordField.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3)
                passwordWarning.layer.opacity = 1
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 1) { [weak self] in
                    guard let self else { return }
                    loginField.backgroundColor = .systemGray6
                    passwordField.backgroundColor = .systemGray6
                    passwordWarning.layer.opacity = 0
                    self.view.layoutIfNeeded()
                }
            }
        } else if loginField.text == "" {
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self else { return }
                loginField.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3)
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 1) { [weak self] in
                    guard let self else { return }
                    loginField.backgroundColor = .systemGray6
                    self.view.layoutIfNeeded()
                }
            }
        } else if passwordField.text == "" || (passwordField.text?.count ?? 0) < 5 {
            UIView.animate(withDuration: 2) { [weak self] in
                guard let self else { return }
                passwordField.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3)
                passwordWarning.layer.opacity = 1
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 2) { [weak self] in
                    guard let self else { return }
                    passwordField.backgroundColor = .systemGray6
                    passwordWarning.layer.opacity = 0
                    self.view.layoutIfNeeded()
                }
            }
        } else {
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }

    @objc func logInPressed(_ sender: UIButton){
        isEmpty(loginTextField: logInTextFieldView, passwordTextField: passwordTextFieldView, passwordWarning: passwordWarningLabel, sender)
    }
}




extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hides keyboard at return tapped
        textField.resignFirstResponder()
        return true
    }
}


