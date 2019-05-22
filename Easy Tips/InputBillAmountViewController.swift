//
//  InputBillAmountViewController.swift
//  Easy Tips
//
//  Created by Johan Park on 5/18/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit
import SuxiNumberInputView

class InputBillAmountViewController: UIViewController {
    
    @IBOutlet weak var textField: CalculateTipTextFieldButton!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Closure logic to calculate tip when "done" button tapped
        textField.buttonTapped = {
            self.calculateBill()
        }
    }
    
    func calculateBill() {
        
        // If keyboard is showing, dismiss it
        if self.textField.isFirstResponder {
            self.textField.resignFirstResponder()
        }
        
        guard let billAmount = self.textField.text,
            let bill = Double(billAmount) else { return }
        
        let roundedBillAmount = (100 * bill).rounded() / 100
        
        // Handles segmented control logic
        let tipPercent: Double
        switch tipSegmentedControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15
        case 1:
            tipPercent = 0.18
        case 2:
            tipPercent = 0.20
        case 3:
            tipPercent = 0.25
        default:
            preconditionFailure("Restricted Index")
        }
        
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        let totalAmount = roundedTipAmount + roundedBillAmount
        
        // Show 2 zeros after decimal point, %.2f - displays 2 decimal points
        self.textField.text = String(format: "$%.2f")
        self.billAmountLabel.text = String(format: "$%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "$%.2f", roundedTipAmount)
        self.totalAmountLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    // Clear text field and labels
    func clear() {
        textField.text = nil
        tipSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
        billAmountLabel.text = "$0.00"
    }
    
    @IBAction func tipPercentageControl(_ sender: UISegmentedControl) {
        calculateBill()
    }
    @IBAction func reset(_ sender: UIButton) {
        clear()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
