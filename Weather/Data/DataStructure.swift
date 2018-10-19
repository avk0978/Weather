//
//  DataStructure.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation

//Data structure for city.list.json file
struct CityList: Decodable {
    let id: Int
    let name: String
    let country: String
    let coord: Coord
}

//Data structure for openweathermap.org site
struct OpenWeather: Decodable {
    let list: [List_]
    let city: City
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}

struct List_: Decodable {
    let main: Main
    let weather:[Weather]
    let clouds: Clouds
    let wind: Wind
    let dt_txt: String
}

struct Main: Decodable {
    let temp: Float
    let humidity: Int
}

struct Weather: Decodable {
    let main: String
}
struct Clouds: Decodable {
    let all: Int
}
struct Wind: Decodable {
    let speed: Float
}
