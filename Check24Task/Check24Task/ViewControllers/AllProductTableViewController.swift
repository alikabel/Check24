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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allProducts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableViewCell

        cell.productNameLabel.text = allProducts[indexPath.row].name
        cell.productDesriptionLabel.text = allProducts[indexPath.row].shortDescription
        cell.priceLabel.text = String(allProducts[indexPath.row].price.value)
        return cell
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
