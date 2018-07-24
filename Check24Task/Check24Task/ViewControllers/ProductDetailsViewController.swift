//
//  ProductDetailsViewController.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import UIKit
import SafariServices

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productDate: UILabel!
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
        productDate.text = product?.getDate((product?.releaseDate)!)
        longDescription.text = product?.longDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func openWebView(_ sender: Any) {
        let safariController = SFSafariViewController(url: URL(string: "http://m.check24.de/rechtliche-hinweise?deviceoutput=app")!)
        present(safariController, animated: true, completion: nil)
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
