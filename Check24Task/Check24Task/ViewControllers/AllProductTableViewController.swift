//
//  AllProductTableViewController.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import UIKit

class AllProductTableViewController: UITableViewController {

    // MARK:- Initilization
    
    let reuseIdentifier = "ProductTableViewCell"
    var allProducts = [Product]()
    // MARK:- View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "CHECK24"
        addRefereshController()
        registerCell()
        getAllProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Allee Products"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "@2018 Check24"
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableViewCell

        cell.productNameLabel.text = allProducts[indexPath.row].name
        cell.productDesriptionLabel.text = allProducts[indexPath.row].shortDescription
        cell.priceLabel.text = String(allProducts[indexPath.row].price.value)
        cell.priceLabel.text = "Price: \(allProducts[indexPath.row].price.value)"
        cell.dateLabel.text = allProducts[indexPath.row].getDate(allProducts[indexPath.row].releaseDate)
        cell.ratingView.enable = true
        cell.ratingView.starNumber = 2
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! ProductDetailsViewController
                destinationController.product = allProducts[indexPath.row]
            }
        }
    }
    // MARK:- Product API
    @objc func getAllProducts() {
        ProdutctsAPI.getProducts().success{ productsResult in
            self.allProducts = productsResult.products
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
    }
    // MARK:- Helper Methods
    
    func registerCell() {
        let productCell = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(productCell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func addRefereshController() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getAllProducts), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
}
