//
//  DetailVC.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import UIKit
import RealmSwift

class DetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let realm = try! Realm()
    lazy var weatherInCities: Results<RealmWeatherInTheCity> = {realm.objects(RealmWeatherInTheCity.self).sorted(byKeyPath: "index")}()

    
    @IBOutlet weak var conditionWeather: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var wind: UIImageView!
    @IBOutlet weak var strengthOfWind: UILabel!
    @IBOutlet weak var rain: UIImageView!
    @IBOutlet weak var rainIsPossible: UILabel!
    @IBOutlet weak var humidity: UIImageView!
    @IBOutlet weak var humidityPercent: UILabel!
    @IBOutlet weak var stackCollection: UIStackView!
    
    var index = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = weatherInCities[index].city
        
        wind.image = UIImage(named: "Wind.png")
        rain.image = UIImage(named: "Rain_chance.png")
        humidity.image = UIImage(named: "Humidity.png")
        
        conditionWeather.image = UIImage(named: weatherInCities[index].dailyWether[0].condition)
        temperature.text = String(weatherInCities[index].dailyWether[0].temperature) + " ℃"
        strengthOfWind.text = String(weatherInCities[index].dailyWether[0].wind)
        rainIsPossible.text = String(weatherInCities[index].dailyWether[0].rain) + " %"
        humidityPercent.text = String(weatherInCities[index].dailyWether[0].humidity) + " %"
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DetailCell
        cell.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1411764706, blue: 0.1529411765, alpha: 1)
        cell.day.textColor = .white
        cell.temperature.textColor = .white
        
        cell.day.text = weatherInCities[index].dailyWether[indexPath.row].day
        cell.temperature.text = String(weatherInCities[index].dailyWether[indexPath.row].temperature) + " ℃"
        cell.imageCell.image = UIImage(named: weatherInCities[index].dailyWether[indexPath.row].condition)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if  let cell = collectionView.cellForItem(at: indexPath){
            cell.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1411764706, blue: 0.1529411765, alpha: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  let cell = collectionView.cellForItem(at: indexPath) as? DetailCell {
            cell.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.5098039216, blue: 0.137254902, alpha: 1)
            
            for item in weatherInCities[index].dailyWether.enumerated(){
                if item.element.day == cell.day.text {
                    conditionWeather.image = UIImage(named: item.element.condition)
                    temperature.text = String(item.element.temperature) + " ℃"
                    strengthOfWind.text = String(item.element.wind)
                    rainIsPossible.text = String(item.element.rain) + " %"
                    humidityPercent.text = String(item.element.humidity) + " %"
                }
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = stackCollection.frame.size.width
        return CGSize(width: (width - 5)/5, height: 90)
    }

}
