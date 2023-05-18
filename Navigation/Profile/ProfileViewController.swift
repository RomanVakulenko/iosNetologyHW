//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    var textField: UITextField?

    required convenience init?(coder aDecoder: NSCoder, textField: UITextField) {
        self.init(coder: aDecoder)
        self.textField = textField
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame//к моменту отрисовки subview размеры superView будут корректны (потому тутб а не в ДидЛоад)
        setTextField()
        setButton()
    }

    func setTextField() {
        textField = UITextField(frame: CGRect(x: 157, y: profileHeaderView.frame.origin.y+(2*16+100)-34-50, width: 200, height: 50))
        textField?.placeholder = "Waiting for something..."
        textField?.font = UIFont.systemFont(ofSize: 14)
        textField?.textColor = .gray
        self.view.addSubview(textField!)
//        textField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    func setButton(){
        let showStatusButton = UIButton(frame: CGRect(x: 16, y: profileHeaderView.frame.origin.y+(2*16+100), width: self.view.frame.width-32, height: 50))
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.layer.cornerRadius = 4
        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.setTitleColor(UIColor.white, for: .normal)
        (showStatusButton.layer.shadowOffset.width, showStatusButton.layer.shadowOffset.height, showStatusButton.layer.shadowRadius) = (4, 4, 4)
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOpacity = 0.7

        showStatusButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(showStatusButton)
    }

    @objc func buttonPressed(_ sender: UIButton) {
        guard let status = textField?.text else {return}
        print(status)
    }
//    @objc func textFieldEditingDidChange (_ sender: Any) {
//        print("textField: \(String(describing: textField.text))")
//
//        if didTyped(text: textField.text) {
//                // correct password
//                button.isEnabled = true
//            } else {
//                button.isEnabled = false
//            }
//    }
//
//    func didTyped(text: String?) -> Bool {
//        var result = false
//        if text != nil {
//            result = true
//        }
//        return result
//    }

}
