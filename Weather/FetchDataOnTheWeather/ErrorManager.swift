//
//  ErrorManager.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation
import UIKit

public let AVKNetworkingErrorDomain = "kv.in.ua"
public let MissingHTTPResponseError = 100
public let UnexpectedResponseError = 200

protocol  ErrorMessage {
    
    func errorMessageAC(_ errorMessage: String) -> UIAlertController
}

extension ErrorMessage {
    
    func errorMessageAC(_ errorMessage: String) -> UIAlertController {
        let ac = UIAlertController(title: "Возникла следующая ошибка", message: errorMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        ac.addAction(ok)
        return ac
    }
    
}
