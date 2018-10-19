//
//  RealmDataBase.swift
//  Weather
//
//  Created by Andrey Kolpakov on 17.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDailyWeather: Object {
    @objc dynamic var day = "" // Описан в enum Day
    @objc dynamic var condition = ""// Описан в enum Condition
    @objc dynamic var wind: Float = 0.0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var rain: Int = 0
    @objc dynamic var temperature: Float = 0.0
}


class RealmWeatherInTheCity: Object {
    @objc dynamic var index: Int = 0
    @objc dynamic var cityID: Int = 0
    @objc dynamic var city = ""
    var dailyWether = List<RealmDailyWeather>()
}
