//
//  LogInModel.swift
//  Navigation
//
//  Created by Roman Vakulenko on 31.05.2023.
//

import UIKit

struct LogInModel {
    let loginText: String
    let passwordText: String

    static func makeMockModel() -> LogInModel {
        LogInModel(loginText: "Email or phone", passwordText: "Password")


    }
}
