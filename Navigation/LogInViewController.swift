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
        passwordText.placeholder = "  Password"
        passwordText.textColor = .black
        passwordText.isSecureTextEntry = true
        passwordText.font = .systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        passwordText.tintColor = .lightGray
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
        stack.backgroundColor = .systemGray6
        [logInTextFieldView, lineBetweenTextFields, passwordTextFieldView].forEach { stack.addArrangedSubview($0) }
        return stack
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

    private var portraitConstraints = [NSLayoutConstraint]()

    private var landscapeConstraints: [NSLayoutConstraint] = []

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        usePortraitConstraints()

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
        changeConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }

    //MARK: - private methods

    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoView, stackView, buttonView].forEach { contentView.addSubview($0) }
    }

    private func usePortraitConstraints() {
        let safearea = view.safeAreaLayoutGuide
        portraitConstraints = [//base constrains
            scrollView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safearea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safearea.bottomAnchor),

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

            buttonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),// отдельный был бы:  contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            //constrains of stack doesn't need cause of alignment & distribution properties, also we set heights at elements'
            ]
        NSLayoutConstraint.activate(portraitConstraints)
    }
    private func useLandscapeConstraints() {
        let safearea = view.safeAreaLayoutGuide
        landscapeConstraints = [//base constrains
            scrollView.leadingAnchor.constraint(equalTo: safearea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safearea.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safearea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safearea.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            //constrains of content
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor), //есть ниже отдельный
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),

            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            buttonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),// отдельный был бы:  contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            //constrains of stack doesn't need cause of alignment & distribution properties, also we set heights at elements' initialization
        ]
        NSLayoutConstraint.activate(landscapeConstraints)
    }

    private func changeConstraints() {

        let isPortrait = view.frame.size.height > view.frame.size.width
        NSLayoutConstraint.deactivate(portraitConstraints + landscapeConstraints)
        isPortrait ? usePortraitConstraints() : useLandscapeConstraints()
    }
//
//    private func changeConstraints() {
//        if UIDevice.current.orientation.isPortrait {
//            NSLayoutConstraint.deactivate(landscapeConstraints)
//            usePortraitConstraints()
//        } else if UIDevice.current.orientation.isLandscape {
////            NSLayoutConstraint.deactivate(portraitConstraints)
//            useLandscapeConstraints()
//        }
//    }

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
