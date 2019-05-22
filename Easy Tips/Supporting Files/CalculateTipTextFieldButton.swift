//
//  CalculateTipTextFieldButton.swift
//  Easy Tips
//
//  Created by Johan Park on 5/18/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit

class CalculateTipTextFieldButton: UITextField {
    
    var buttonTapped: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let toolbar: UIToolbar = UIToolbar()
        
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let trailingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = UIColor.black
        
        toolbar.items = [leadingFlex, doneButton]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        buttonTapped?()
    }
}
