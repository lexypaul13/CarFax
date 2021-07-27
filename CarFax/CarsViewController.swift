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
                
            case .failure(_ ):
                self.alert(message: CFError.invalidResponse.rawValue, title: "Network Error")
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
        //cell.phoneButton.addTarget(self, action: #selector(CarsViewController.callTapped(_:)), for: .touchUpInside)
        cell.setCell(carFax: car)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let save = UIContextualAction(style: .normal, title: "Save") { (_, _, completionHandler) in
            completionHandler(true)
            self.addCars(savedCars: self.cars[indexPath.row])
            self.alert(message:"" , title: "Saved")
        }
        save.backgroundColor = .systemBlue
        let swipe =  UISwipeActionsConfiguration(actions: [save])
        return swipe
    }
    
    func addCars(savedCars:Listing){
        let savedCars = Listing(dealer: savedCars.dealer, id: savedCars.id, images: savedCars.images, make: savedCars.make, mileage: savedCars.mileage, year: savedCars.year, listPrice: savedCars.listPrice, trim: savedCars.trim, model: savedCars.model, currentPrice: savedCars.currentPrice)
        
        SaveManger.updateWith(favorite: savedCars, actionType: .add, key: SaveManger.Keys.favorites) { error in
            guard error != nil else{
                self.alert(message: "Saved", title: "")
                return
            }
            self.alert(message: CFError.saveFailure.rawValue, title: "")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cars[indexPath.row]
        let destVC = CFImageViewController(carsImages:cell.images.firstPhoto.large)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    //    @objc func callTapped(_ sender: UIButton) {
    //        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
    //        if let indexPath = tableView.indexPathForRow(at: buttonPosition){
    //            let phoneNumber = cars[indexPath.row].dealer.phone
    //           print("taped\(phoneNumber)")
    //        }
    //
    //    }
    //
    
    
    
}
