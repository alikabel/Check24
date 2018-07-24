//
//  ProductDetailsViewController.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productName.text = product?.name
        let price = product?.price.value
        productPrice.text = String(describing: price!)
        shortDescription.text = product?.shortDescription
        
//        longDescription.text = product.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
