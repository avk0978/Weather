//
//  FetchOfWeatherDataByCoordinates.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct  Coordinates {
    var latitude: Double
    var longitude: Double
}

// For example: https://api.openweathermap.org/data/2.5/forecast?lat=42.53474&lon=1.58014&APPID=691b34c875fcc86e18c8152c5e194ae2

enum ForecastType: FinalURLPoint {
    
    case Curent(coordinates: Coordinates, appId: String)
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }
    var path: String {
        switch  self {
        case .Curent(let coordinates , let appId):
            return "/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&units=metric&APPID=\(appId)"
        }
    }
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    
}


final class WeatherData: APIManager {
    var pathToFile: String?
    var sessionConfiguration: URLSessionConfiguration
    let appId: String
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(sessionConfiguration: URLSessionConfiguration, appId: String, pathToFile: String?) {
        self.sessionConfiguration = sessionConfiguration
        self.appId = appId
        self.pathToFile = pathToFile
    }
    
    convenience init (appId: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, appId: appId, pathToFile: nil)
    }
    
    func fetchForecastBy(coordinates: Coordinates, completionHandler: @escaping (APIResult<OpenWeather>) -> Void) {
        let urlRequest = ForecastType.Curent(coordinates: coordinates, appId: self.appId).request
        fetch(request: urlRequest) { (resultApi) in
            completionHandler(resultApi)
        }
    }
}



