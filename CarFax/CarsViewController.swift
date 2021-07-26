//
//  CarsViewController.swift
//  CarFax
//
//  Created by Alex Paul on 7/21/21.
//

import UIKit

class CarsViewController: UIViewController {
    let tableView = UITableView()
    var cars = [Listing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableViewController()
        getCars()
    }
    
    func configureViewController(){
        title = "Cars"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableViewController(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 250
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CFTableViewCell.self, forCellReuseIdentifier: CFTableViewCell.resuseIdentifier)
    }
    
    func getCars(){
        NetworkManger.sharedTask.getCars { [weak self] results in
            guard let self = self else {return}
            switch results{
            case .success(let cars ):
                self.cars = cars.listings
                DispatchQueue.main.async {self.tableView.reloadData()}
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}


extension CarsViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CFTableViewCell.resuseIdentifier) as! CFTableViewCell
        let car = cars[indexPath.row]
        cell.setCell(carFax: car)
        return cell
        
    }
    
    
}
