//
//  ViewController.swift
//  Calculator
//
//  Created by Ruurd Pels on 31/05/2015.
//  Copyright (c) 2015 Ruurd Pels. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentlyTypingANumber: Bool = false
    
    @IBOutlet weak var display: UILabel!
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if currentlyTypingANumber == true {
            display.text = display.text! + digit
        } else {
            display.text = digit
            currentlyTypingANumber = true
        }
    }
}

