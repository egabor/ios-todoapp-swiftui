//
//  ButtonLoadingCapable.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 19..
//

import Foundation

protocol ButtonLoadingCapable: AnyObject {
    var isButtonLoading: Bool { get set }
}

extension ButtonLoadingCapable {
    func setButtonLoadingOnMain(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isButtonLoading = value
        }
    }
}
