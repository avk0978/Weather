//
//  SitiesCollectionVC.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import RealmSwift

private let reuseIdentifier = "Cell"
private var toggle = true

class CitiesCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, ErrorMessage, FunctionsOfTheWeatherApp, CLLocationManagerDelegate {
    
    let realm = try! Realm()
    lazy var weatherInCities: Results<RealmWeatherInTheCity> = {realm.objects(RealmWeatherInTheCity.self).sorted(byKeyPath: "index")}()
    
    let locationManager = CLLocationManager()
    var myLocation: CLLocation!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func getWeatherByCurrentCoordinates(_ sender: UIBarButtonItem) {
        getWetherBy(coordinates: Coordinates(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude), index: 0, currentCoord: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        collectionView?.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1137254902, blue: 0.1254901961, alpha: 1)
        addCitiesToList(count: 2500) // Кол-во загружаемых городов
        getWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         myLocation = locations.last! as CLLocation
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CityCell
        
        if toggle {
            cell.backgroundColor = .clear
            cell.temperature.textColor = .clear
            cell.nameCity.textColor = .clear
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1411764706, blue: 0.1529411765, alpha: 1)
            cell.temperature.textColor = .white
            cell.nameCity.textColor = .white
            if realmBDIsEmpty() {
                cell.nameCity.text = cityWeather[indexPath.row].city
                cell.temperature.text = String(cityWeather[indexPath.row].daytime[0].temperature) + " ℃"
                cell.imageWeather.image = cityWeather[indexPath.row].daytime[0].condition.image
            } else {
                cell.nameCity.text = weatherInCities[indexPath.row].city
                cell.temperature.text = String(weatherInCities[indexPath.row].dailyWether[0].temperature) + " ℃"
                cell.imageWeather.image = UIImage(named: weatherInCities[indexPath.row].dailyWether[0].condition)
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width
        let heightNB = navigationController?.navigationBar.frame.size.height
        if width < height {
            return CGSize(width: (width - 24)/3, height: (height - 70 - heightNB!)/4)
        } else {
            return CGSize(width: (width - 24)/3, height: (height - 120 - heightNB!)/2)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = collectionView?.indexPathsForSelectedItems {
                let dvc = segue.destination as! DetailVC
                dvc.index = indexPath[0].row
            }
        }
    }
    
    func addCitiesToList(count: Int) {
        let citiesList = CitiesList(pathToFile: Bundle.main.path(forResource: "city.list", ofType: "json")!)
        toggleActivityIndicator(on: true)
        guard theCitiesCoordinatesIsEmpty() else { return }
        
        citiesList.downloadCitiesList { (result) in
            switch result {
            case .Success(let cities):
                self.loadLettersOfTheAlphabet()
                for index in 0...count {
                    self.save(city: cities![index], index)
                }
                self.getWeather()
            case .Falure(let error as NSError):
                let errorAC = self.errorMessageAC("\(error.localizedDescription)")
                self.present(errorAC, animated: true, completion: nil)
            }
        }
    }
    
    func getWetherBy(coordinates: Coordinates, index: Int, currentCoord: Bool) {
        let weather = WeatherData(appId: "691b34c875fcc86e18c8152c5e194ae2")
        weather.fetchForecastBy(coordinates: coordinates) { (result) in
            switch result {
            case .Success(let cities):
                if self.parsingWeatherData(forecast: cities, indexCity: index) {
                    self.collectionView?.reloadData()
                    guard currentCoord else { break }
                    if !self.searchCityWith(id: (cities?.city.id)!) {
                        self.save(city: CityList(id: (cities?.city.id)!,
                                                 name: (cities?.city.name)!,
                                                 country: (cities?.city.country)!,
                                                 coord: (cities?.city.coord)!), 0)
                        self.selectedCityWith(iD: (cities?.city.id)!)
                    } else {
                        self.selectedCityWith(iD: (cities?.city.id)!)
                    }
                } else {
                    let ac = UIAlertController(title: "Ошибка", message: "Сервер не предоставил данных о погоде", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    ac.addAction(ok)
                    self.present(ac, animated: true)
                }
            case .Falure(let error as NSError):
                let errorAC = self.errorMessageAC("\(error.localizedDescription)")
                self.present(errorAC, animated: true, completion: nil)
            }
        }
    }
    
    func getWeather() {
        let cytiCoordinates = fetchCitiesCoordinatesFromDataBase()
        guard cytiCoordinates.count != 0 else { return }
        for index in 0...cytiCoordinates.count - 1 {
            getWetherBy(coordinates: cytiCoordinates[index], index: index, currentCoord: false)
            }
        toggleActivityIndicator(on: false)
        }
    
    func toggleActivityIndicator(on: Bool) {
        toggle = on
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}










