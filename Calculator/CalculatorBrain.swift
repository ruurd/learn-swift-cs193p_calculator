//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ruurd Pels on 03/10/2015.
//  Copyright © 2015 Ruurd Pels. All rights reserved.
//

import Foundation

class CalculatorBrain {

    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }

    var opStack = Array<Op>()
    var knownOps = Dictionary<String, Op>()
    
    init() {
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$0 / $1}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$0 - $1}
        knownOps["−"] = Op.UnaryOperation("−") {-$0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }

}
