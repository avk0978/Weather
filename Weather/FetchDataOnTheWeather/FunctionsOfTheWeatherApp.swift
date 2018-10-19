//
//  WeatherCoreDataDelegate.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import RealmSwift

protocol FunctionsOfTheWeatherApp {
    func changingTheOrderOfTheCityInStack()
    func loadLettersOfTheAlphabet()
    func fetchCitiesCoordinatesFromDataBase() -> [Coordinates]
    func save(city: CityList, _ index: Int)
    func searchCityWith(id: Int) -> Bool
    func searchCityInStackWith(id: Int) -> Bool
    func selectedCityWith(iD: Int)
    func selectedCityWith(name: String)
    func parsingWeatherData(forecast: OpenWeather?, indexCity: Int) -> Bool
    func theCitiesCoordinatesIsEmpty() -> Bool
    func realmBDIsEmpty() -> Bool
}

extension FunctionsOfTheWeatherApp {
    
    func theCitiesCoordinatesIsEmpty() -> Bool {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        var records = 0
        do {
            let count = try context?.count(for: fetchRequest)
            records = count!
            print("""
                Проверяем наличие записей в БД................................
                Обнаруженно \(records) записей
                """)
        } catch { print(error.localizedDescription) }
        if records == 0 { return true }
        else { return false }
    }
    
    func realmBDIsEmpty() -> Bool {
        let realm = try! Realm()
        let results: Results<RealmWeatherInTheCity> = {realm.objects(RealmWeatherInTheCity.self)}()
        if results.count == 6 { return false }
        else { return true }
    }
    
    func loadLettersOfTheAlphabet() {
        let letters: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CitiesCoordinates", in: context!)
        for letter in letters {
            let object = NSManagedObject(entity: entity!, insertInto: context) as! CitiesCoordinates
            object.name = letter
            do {
                try context?.save()
            } catch { print(error.localizedDescription) }
        }
    }
    
    func save(city: CityList, _ index: Int) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CitiesCoordinates", in: context!)
        let object = NSManagedObject(entity: entity!, insertInto: context) as! CitiesCoordinates
        if index < 7 { object.cellNumber = Int16(index)}
        object.cityID = Int32(city.id)
        object.country = city.country
        object.name = city.name
        object.lat = city.coord.lat
        object.lon = city.coord.lon
        do {
            try context?.save()
            print("""
                Сохранен город: \(city.name)  № ячейки \(object.cellNumber).....................
                """)
        } catch { print(error.localizedDescription) }
    }

    func selectedCityWith(name: String) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            if let objects = try context?.fetch(fetchRequest){
                if objects[0].cellNumber == 0 {
                    changingTheOrderOfTheCityInStack()
                    objects[0].cellNumber = 1
                } else { return }
            }
        } catch { print(error.localizedDescription)}
        do {
            try context?.save()
        } catch { print(error.localizedDescription) }
    }
    
    func selectedCityWith(iD: Int) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityID == \(iD)")
        do {
            if let objects = try context?.fetch(fetchRequest){
                if objects[0].cellNumber == 0 {
                    changingTheOrderOfTheCityInStack()
                    objects[0].cellNumber = 1
                }
            } else { return }
        } catch { print(error.localizedDescription)}
        do {
            try context?.save()
        } catch { print(error.localizedDescription) }
    }
    
    func searchCityWith(id: Int) -> Bool{
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityID == \(id)")
        do {
            if let objects = try context?.fetch(fetchRequest){
                if objects.count > 0 { return true }
            }
        } catch { print(error.localizedDescription) }
        return false
    }
    
    func searchCityInStackWith(id: Int) -> Bool{
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityID == \(id)")
        do {
            if let objects = try context?.fetch(fetchRequest){
                if objects[0].cellNumber > 0 { return true }
            }
        } catch { print(error.localizedDescription) }
        return false
    }
    



    func changingTheOrderOfTheCityInStack(){
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "cellNumber", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "cellNumber != 0")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            if let objects = try context?.fetch(fetchRequest) {
                guard objects.count != 0 else { return }
                for index in 0...objects.count - 1{
                    if objects[index].cellNumber < 6 { objects[index].cellNumber += 1}
                    else { objects[index].cellNumber = 0 }
                }
            }
        } catch { print(error.localizedDescription) }
        do {
            try context?.save()
        } catch { print(error.localizedDescription) }
    }
    
    func fetchCitiesCoordinatesFromDataBase() -> [Coordinates] {
        var coordinates: [Coordinates] = []
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "cellNumber", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "cellNumber != 0")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            if let objects = try context?.fetch(fetchRequest) {
                for object in objects {
                    coordinates.append(Coordinates(latitude: object.lat, longitude: object.lon))
                }
            }
        } catch { print(error.localizedDescription) }

        return coordinates
    }
    
    private func deleteCitiesWith(index: Int) {
        let realm = try! Realm()
        let cities: Results<RealmWeatherInTheCity> = {realm.objects(RealmWeatherInTheCity.self).sorted(byKeyPath: "index")}()
        for city in cities {
            if city.index == index {
                do {
                    try realm.write {
                        realm.delete(city)
                    }
                } catch { print(error.localizedDescription) }
            }
        }
    
    }
    
    func parsingWeatherData(forecast: OpenWeather?, indexCity: Int) -> Bool {
        
        let realm = try! Realm()
        let weatherInCity = RealmWeatherInTheCity()
        
        deleteCitiesWith(index: indexCity)

        weatherInCity.index = indexCity
        if let cityID = forecast?.city.id { weatherInCity.cityID = cityID } else { return false }
        if let cityName = forecast?.city.name { weatherInCity.city = cityName } else { return false }
        
        var nextDay = 0
        for _ in 0...4 {
            let dailyWether = RealmDailyWeather()
            // Инициализируем dailyWether
            if let temp = forecast?.list[nextDay].main.temp { dailyWether.temperature = temp } else { return false }
            if let hum = forecast?.list[nextDay].main.humidity { dailyWether.humidity = hum } else { dailyWether.humidity = 0}
            if let cond = forecast?.list[nextDay].weather[0].main { dailyWether.condition = self.weatherCondition(weather: cond) }
            else { dailyWether.condition = "Weather3.png" }
            if let wind = forecast?.list[nextDay].wind.speed { dailyWether.wind = wind} else { dailyWether.wind = 0 }
            if let cloud = forecast?.list[nextDay].clouds.all {dailyWether.rain = cloud } else { dailyWether.rain = 0 }
            if let date = forecast?.list[nextDay].dt_txt { dailyWether.day = dayOfWeek(date) } else { return false }
            
            // Инициализируем масив dailyWethers
            weatherInCity.dailyWether.append(dailyWether)
            nextDay += 8
        }
        
        do {
            try realm.write {
                realm.add(weatherInCity)
            }
        } catch { print(error.localizedDescription) }
        return true
    }
    
    func weatherCondition(weather: String) -> String {
        switch weather {
        case "Clouds":
            return "Weather1.png"
        case "Clear":
            return "Weather3.png"
        case "Partly cloud":
            return "Weather4.png"
        case "Rain":
            return "Weather5.png"
        case "Thunder storm":
            return "Weather2.png"
        default:
            return "Weather3.png"
        }
    }

    
    func dayOfWeek(_ dateStr: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let date = dateFormater.date(from: dateStr)
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let myComponents = myCalendar?.component(.weekday, from: date!)
        switch myComponents {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        default:
            return "Saturday"
        }
    }


 }
