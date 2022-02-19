//
//  LoadingCapable.swift
//  ios-todoapp-swiftui
//
//  Created by Eszenyi Gábor on 2022. 02. 19..
//

import Foundation

protocol LoadingCapable: AnyObject {
    var isLoading: Bool { get set }
}

extension LoadingCapable {
    func setLoadingOnMain(to value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = value
        }
    }
}
