//
//  InitialSearchTable.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//
//
import Foundation
import UIKit
import CoreData



final class CitiesList: APIManager, ErrorMessage{
    
    var sessionConfiguration: URLSessionConfiguration
    var pathToFile: String?
    var url: String?
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(sessionConfiguration: URLSessionConfiguration, url: String?, pathToFile: String?) {
        self.sessionConfiguration = sessionConfiguration
        self.url = url
        self.pathToFile = pathToFile
    }
    
    convenience init (pathToFile: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, url: nil, pathToFile: pathToFile)
    }

    
    func downloadCitiesList(completionHandler: @escaping (APIResult<[CityList]>) -> Void) {
        let urlRequest = URLRequest(url: URL(fileURLWithPath: pathToFile!))
        fetch(request: urlRequest) { (resultApi) in
            completionHandler(resultApi)
        }
    }
    
}

