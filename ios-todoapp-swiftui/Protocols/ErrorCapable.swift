//
//  ErrorCapable.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 19..
//

import Foundation
import TodoAppNetwork

protocol ErrorCapable: AnyObject {
    var showError: Bool { get set }
    var errorMessage: String { get set }
}

extension ErrorCapable {
    func showErrorOnMain(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = message
            self?.showError = true
        }
    }

    func showNetworkErrorOnMain(error: TodoAppNetwork.Common.ErrorMessage.Response) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = R.string.localizable.alertMessageStatusCode(error.statusCode ?? -1)
            self?.showError = true
        }
    }

    var errorAlertTitle: String {
        R.string.localizable.alertErrorTitle()
    }

    var errorAlertOkButtonTitle: String {
        R.string.localizable.alertErrorButtonOk()
    }
}
