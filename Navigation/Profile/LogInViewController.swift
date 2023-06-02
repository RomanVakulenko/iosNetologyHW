//
//  LogInViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 31.05.2023.
//

import UIKit

final class LogInViewController: UIViewController {

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

    private let textAlignment: CGFloat = 6

    private lazy var logInTextFieldView: UITextField = { [unowned self] in
        let logInText = UITextField()
        logInText.translatesAutoresizingMaskIntoConstraints = false
        logInText.autocorrectionType = .no
        logInText.keyboardType = .default
        logInText.returnKeyType = .done
        logInText.clearButtonMode = .whileEditing
        logInText.contentVerticalAlignment = .center
        logInText.placeholder = "  Email or phone"
        logInText.layer.sublayerTransform = CATransform3DMakeTranslation(textAlignment, 0, 0)
        logInText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        logInText.tintColor = .lightGray
        logInText.autocapitalizationType = .none
        return logInText
    }()

    private lazy var passwordTextFieldView: UITextField = { [unowned self] in
        let passwordText = UITextField()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.placeholder = "  Password"
        passwordText.layer.sublayerTransform = CATransform3DMakeTranslation(textAlignment, 0, 0)
        passwordText.textColor = .black
        passwordText.isSecureTextEntry = true
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

    private lazy var buttonView: UIButton = { [unowned self] in
        let logInButton = UIButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
//        logInButton.backgroundColor = UIColor(hex: 0x4885CC)
        if let colorFromFile = UIImage(named: "blue_pixel") {
            logInButton.backgroundColor = UIColor(patternImage: colorFromFile)
        }
        logInButton.layer.cornerRadius = 10
        logInButton.setTitle("Log in", for: .normal)
        logInButton.addTarget(self, action: #selector(logInPressed(_:)), for: .touchUpInside)
        return logInButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        customizeStackView()
        setupScrollViewContent()
        logInTextFieldView.delegate = self
        passwordTextFieldView.delegate = self

        scrollView.keyboardDismissMode = .onDrag

        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .automatic
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        underline1stTextField()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }

    private func underline1stTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: -textAlignment, y: logInTextFieldView.frame.height-1.0, width: logInTextFieldView.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        logInTextFieldView.borderStyle = .none
        logInTextFieldView.layer.addSublayer(bottomLine)
    }

    private func customizeStackView(){
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
    }

    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoView, stackView, buttonView].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        let safearea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safearea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safearea.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    private func setupScrollViewContent() {
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),

            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            logInTextFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInTextFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInTextFieldView.topAnchor.constraint(equalTo: stackView.topAnchor),
            logInTextFieldView.heightAnchor.constraint(equalToConstant: 50),

            passwordTextFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            passwordTextFieldView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 50),

            buttonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
            scrollView.scrollRectToVisible(buttonView.frame, animated: true)
        }
    }

    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }

    @objc func logInPressed(_ sender: UIButton){
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
