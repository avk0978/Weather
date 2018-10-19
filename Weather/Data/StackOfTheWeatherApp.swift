//
//  InitialSettings.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation


var dailyWeather_1: [DailyWeather] = [DailyWeather(day: .monday, condition: .clear, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .tuesday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .wednesday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .thursday , condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .friday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0)]

var dailyWeather_2: [DailyWeather] = [DailyWeather(day: .monday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .tuesday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .wednesday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .thursday , condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .friday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0)]

var dailyWeather_3: [DailyWeather] = [DailyWeather(day: .monday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .tuesday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .wednesday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .thursday , condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .friday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0)]

var dailyWeather_4: [DailyWeather] = [DailyWeather(day: .monday, condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .tuesday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .wednesday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .thursday , condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .friday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0)]

var dailyWeather_5: [DailyWeather] = [DailyWeather(day: .monday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .tuesday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .wednesday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .thursday , condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .friday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0)]

var dailyWeather_6: [DailyWeather] = [DailyWeather(day: .monday, condition: .clear, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .tuesday, condition: .partlyCloudy, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .wednesday, condition: .cloudy, wind: 0, humidity: 0, rain: 0, temperature:0),
                                      DailyWeather(day: .thursday , condition: .rain, wind: 0, humidity: 0, rain: 0, temperature: 0),
                                      DailyWeather(day: .friday, condition: .storm, wind: 0, humidity: 0, rain: 0, temperature: 0)]


var cityWeather: [WeatherInTheCity] = [WeatherInTheCity(cityID: 0, city: "No data", daytime: dailyWeather_1),
                                       WeatherInTheCity(cityID: 0, city: "No data", daytime: dailyWeather_2),
                                       WeatherInTheCity(cityID: 0, city: "No data", daytime: dailyWeather_3),
                                       WeatherInTheCity(cityID: 0, city: "No data", daytime: dailyWeather_4),
                                       WeatherInTheCity(cityID: 0, city: "No data", daytime: dailyWeather_5),
                                       WeatherInTheCity(cityID: 0, city: "No data", daytime: dailyWeather_6)]








