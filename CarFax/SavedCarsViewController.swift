//
//  SavedCarsViewController.swift
//  CarFax
//
//  Created by Alex Paul on 7/21/21.
//

import UIKit

class SavedCarsViewController: UIViewController {
    
    let tableView = UITableView()
    var cars = [Listing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableViewController()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteCars()
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
    
    
    func getFavoriteCars(){
        SaveManger.collectFavorties{ [weak self ] result in
            guard let self = self else { return}
            switch result{
            case .success(let favorites):
                self.cars = favorites
                DispatchQueue.main.async {self.tableView.reloadData()}
          
            case .failure( _):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Cannot", message:"Something went wrong" ,preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            
            
        }
        
    }
    
}


extension SavedCarsViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CFTableViewCell.resuseIdentifier) as! CFTableViewCell
        let favoriteCar = cars[indexPath.row]
        cell.setCell(carFax: favoriteCar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = cars[indexPath.row]
        cars.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        SaveManger.updateWith(favorite: favorite, actionType: .remove, key: SaveManger.Keys.favorites) { [weak self] error in
            guard self != nil else { return }
            guard error != nil else { return }
            
        }
        
    }
    
    
    
}
