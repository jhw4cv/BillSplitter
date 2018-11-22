//
//  ViewController.swift
//  Bill Splitter
//
//  Created by Jack Workman on 10/1/18.
//  Copyright © 2018 Jack Workman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items : [Double] = [] // Array that will hold prices
    @IBOutlet var table: UITableView! // Table that will hold prices
    
    @IBOutlet var flatPrice: UITextField!
    @IBOutlet var priceWithTax: UITextField!
    @IBOutlet var itemPrice: UITextField!
    @IBOutlet var amountOwed: UILabel!
    
    @IBAction func addItem(_ sender: Any) {
        var price : Double
        let priceField = itemPrice.text
        if let price = Double(priceField!) {
            items.append(price)
            table.reloadData()
            amountOwed.text = "$ " + String(computeAmountOwed())
        }
    }
    
    func computeAmountOwed() -> Double {
        var sum = 0.0
        for i in items {
            sum += i
        }
        let flatAmountText = flatPrice.text
        if let flatAmount = Double(flatAmountText!) {
            let withTipAndTaxText = priceWithTax.text
            if let withTipAndTax = Double(withTipAndTaxText!) {
                let proportion = sum/flatAmount
                let amountOwed = sum + proportion*(withTipAndTax - flatAmount)
                return amountOwed
            }
        }
        return 0.0
    }
    
    
    // Responsible for tracking rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // Builds table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(items[indexPath.row])
        return cell
    }
    
    // Allows deletion of certain items in table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            items.remove(at: indexPath.row)
            table.reloadData()
            UserDefaults.standard.set(items, forKey: "items")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}

