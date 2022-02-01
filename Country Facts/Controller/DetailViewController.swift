
//
//  DetailViewController.swift
//  Country Facts
//
//  Created by António Rocha on 17/12/2021.
//

import UIKit
import SwiftSVG

class DetailViewController: UITableViewController {
    
    var flagLink: String?
    var name: String?
    var capital: String?
    var region: String?
    var subregion: String?
    var population: String?
    var area: String?
    var currency: String?
    
    var facts = [String]()
    var categories = [String]()
    var flagImage = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "factsCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let flagLink = flagLink,
            let name = name,
            let capital = capital,
            let region = region,
            let subregion = subregion,
            let currency = currency,
            let area = area,
            let population = population {
                facts = [capital, region, subregion, currency, area, population]
                title = "\(name)"
                loadImage(with: flagLink)
                //performSelector(inBackground: #selector(loadImage), with: flagLink)
        } else {
            return
        }
        categories = ["Capital","Region","Subregion","Currency","Area","Population"]
    }
   

//MARK: - Showing the Data
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "factsCell", for: indexPath)
        if indexPath.row == 0 {
            cell.addSubview(flagImage)
            cell.textLabel?.text = ""
        } else {
            self.tableView.rowHeight = 50
            let fact = facts[indexPath.row - 1]
            let category = categories[indexPath.row - 1]
            cell.textLabel?.text = "\(category): \(fact)"
        }
        print(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        } else {
            return UITableView.automaticDimension
        }
    }
    
    @objc func loadImage(with flagLink: String) {
        
        let svgURL = URL(string: flagLink)!
        let imageView = UIView(SVGURL: svgURL) { (svgLayer) in
           svgLayer.resizeToFit(CGRect(x: 0, y: 0, width: 500, height: 100))
       }
        flagImage = imageView
        tableView.reloadData()
//        let url = URL(string: flagLink)!
//        if let data = try? Data(contentsOf: url) {
//            if let image = UIImage(data: data) {
//                flagImage = image
//            }
//        }
    //performSelector(onMainThread: #selector(reload), with: nil, waitUntilDone: false)
    }
    
//    @objc func reload() {
//        tableView.reloadData()
//    }
    
}
