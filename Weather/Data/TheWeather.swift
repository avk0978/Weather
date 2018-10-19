//
//  TheWeather.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation
import UIKit

enum Condition {
    case clear
    case partlyCloudy
    case cloudy
    case rain
    case storm
    var image: UIImage {
        switch self {
        case .clear: return UIImage(named: "Weather3.png")!
        case .partlyCloudy: return UIImage(named: "Weather4.png")!
        case .cloudy: return UIImage(named: "Weather1.png")!
        case .rain: return UIImage(named: "Weather5.png")!
        case .storm: return UIImage(named: "Weather2.png")!
        }
    }
}

enum Day {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    var value: String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }
}

struct DailyWeather {
    var day: Day
    var condition: Condition
    var wind: Float
    var humidity: Int
    var rain: Int
    var temperature: Float
}


struct WeatherInTheCity {
    var cityID: Int
    var city: String
    var daytime: [DailyWeather]
}


























