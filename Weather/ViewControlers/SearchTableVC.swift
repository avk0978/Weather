//
//  SearchTableVC.swift
//  Weather
//
//  Created by Andrey Kolpakov on 16.10.2018.
//  Copyright © 2018 Andrey Kolpakov. All rights reserved.
//

import UIKit
import CoreData


class SearchTableVC: UITableViewController, FunctionsOfTheWeatherApp {
    
    var searchController: UISearchController!
    var searchResult: [CitiesCoordinates] = []
    var cityArray: [CitiesCoordinates] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CitiesCoordinates> = CitiesCoordinates.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            cityArray = (try context?.fetch(fetchRequest))!
        } catch { print(error.localizedDescription) }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.09803921569, green: 0.1137254902, blue: 0.1254901961, alpha: 1)
        searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1411764706, blue: 0.1529411765, alpha: 1)
            textField.attributedText = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func filteredCities(searchText text: String){
        searchResult = cityArray.filter { (cityArray) -> Bool in
            return (cityArray.name?.lowercased().contains(text.lowercased()))!
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" { return searchResult.count}
        return cityArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchCell
        cell.cityName.text = cityToDisplayAt(index: indexPath).name
        return cell
    }
    
    func cityToDisplayAt(index: IndexPath) -> CitiesCoordinates {
        let city: CitiesCoordinates
        if searchController.isActive && searchController.searchBar.text != "" { city = searchResult[index.row] }
        else {city = cityArray[index.row]}
        return city
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchCell
        guard let cityName = cell.cityName.text else { return }
        guard exception(cityName) else { return }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CitiesCollectionVC") as! CitiesCollectionVC
        selectedCityWith(name: cityName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func exception(_ letter: String) -> Bool {
        switch letter {
        case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
            return false
        default:
            return true
        }
    }
    
}

extension SearchTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredCities(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}



















