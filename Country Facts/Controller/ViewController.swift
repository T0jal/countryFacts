//
//  ViewController.swift
//  Country Facts
//
//  Created by António Rocha on 17/12/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mandar isto pa background thread
        performSelector(inBackground: #selector(fetchData), with: nil)
    }
    
    @objc func reloadData() {
        tableView.reloadData()
    }

//MARK: - Getting the Data
    
    @objc func fetchData() {
        let urlString = "https://restcountries.com/v2/all?fields=flag,name,capital,subregion,region,population,area,currencies"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        do {
            let jsonCountries = try decoder.decode([Country].self, from: json)
            countries = jsonCountries
            
//            let jsonCountriesName = jsonCountries.map(\.name)
//            print(jsonCountriesName)
            
            performSelector(onMainThread: #selector(reloadData), with: nil, waitUntilDone: false)
        } catch let error {
            print(error)
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
//MARK: - Showing the Data
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
    

//MARK: - Sending the Data to the Detail View Controller
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.flagLink = countries[indexPath.row].flag
        vc.name = countries[indexPath.row].name
        vc.region = countries[indexPath.row].region
        vc.subregion = countries[indexPath.row].subregion
        vc.population = String(countries[indexPath.row].population)
        
        if countries[indexPath.row].capital == "" {
            vc.capital = "N/A"
        } else {
            vc.capital = countries[indexPath.row].capital
        }
        
        if (countries[indexPath.row].currencies).isEmpty {
            vc.currency = "N/A"
        } else {
            vc.currency = countries[indexPath.row].currencies[0].name
        }
        
        if let area = countries[indexPath.row].area {
            vc.area = String(area)
        } else {
            vc.area = "N/A"
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
