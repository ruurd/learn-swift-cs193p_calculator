//
//  ViewController.swift
//  Calculator
//
//  Created by Ruurd Pels on 31/05/2015.
//  Copyright (c) 2015 Ruurd Pels. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentlyTypingANumber = false
    var noDotTypedYet = true
    var operandStack = Array<Double>()
    
    // display is an optional + bang. This means
    // that if you use it you get the value back
    // without asking for it with a bang later on.
    @IBOutlet weak var display: UILabel!

    // Computed property that mirrors the value in
    // the display as a double
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
    
    // Pick the digit from the sender and append
    // it to the display title
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if currentlyTypingANumber == true {
            if ((digit == ".") && noDotTypedYet) {
                display.text = display.text! + digit
                if (digit == ".") {
                    noDotTypedYet = false
                }
            } else {
                display.text = display.text! + digit
            }
        } else {
            if ((digit == ".") && noDotTypedYet) {
                display.text = "0" + digit
            } else {
                display.text = digit
            }
            currentlyTypingANumber = true
        }
    }

    // Make sure you disengage the enter button from
    // appendDigit handler after copy-and-paste
    @IBAction func enter() {
        currentlyTypingANumber = false
        operandStack.append(displayValue)
        println("operand stack = \(operandStack)")
    }

    @IBAction func set(sender: UIButton) {
        let constant = sender.currentTitle!
        
        // Make the operator keys work as enter if we're currently a number
        // so we don't need to push it on the operand stack
        if currentlyTypingANumber {
            enter()
        }
        
        switch constant {
        case "pi": displayValue = M_PI
        default: break
        }
        enter()
    }
    
    // Handle the operator keys
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        // Make the operator keys work as enter if we're currently a number
        // so we don't need to push it on the operand stack
        if currentlyTypingANumber {
            enter()
        }
        
        switch operation {
        case "×": performOperation{$1 * $0}
        case "÷": performOperation{$1 / $0}
        case "+": performOperation{$1 + $0}
        case "−": performOperation{$1 - $0}
        case "√": performOperation{sqrt($0)}
        case "sin": performOperation{sin($0)}
        case "cos": performOperation{cos($0)}
        default: break
        }
    }

    // Because this class inherits from NSObject public methods are exposed
    // to the Obj-C runtime. If this method and the following are made public
    // they will cause a naming conflict
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast());
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast());
            enter()
        }
    }
    
}

