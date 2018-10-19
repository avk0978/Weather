//
//  APIManager.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation

enum APIResult<T>{
    case Success(T?)
    case Falure(Error?)
}

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIManager {
    
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    var pathToFile: String? { get }
    
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (APIResult<T>) -> Void) -> Void
    
}
extension APIManager {
    
    
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (APIResult<T>) -> Void) -> Void {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                guard let data = data else {
                    completionHandler(.Falure(error))
                    return
                }
                guard (response as? HTTPURLResponse) != nil || self.pathToFile != nil else {
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("HTTP response is missing", comment: "")]
                    let error = NSError(domain: AVKNetworkingErrorDomain, code: 100, userInfo: userInfo)
                    completionHandler(.Falure(error))
                    return
                }
                guard error == nil else {
                    completionHandler(.Falure(error))
                    return
                }
                do {
                    let currencyData = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.Success(currencyData))
                } catch let error{
                    print ("Ошибка ковертации данных JSON API Manager")
                    completionHandler(.Falure(error))
                }
            })
            }.resume()
    }
    
}
