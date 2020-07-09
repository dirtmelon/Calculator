//
//  CalculatorButtonItem.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/9.
//

import Foundation
import CoreGraphics

enum CalculatorButtonItem {
  enum Op: String {
    case plus = "+"
    case minus = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
  }
  
  enum Command: String {
    case clear = "AC"
    case flip = "+/-"
    case percent = "%"
  }
  
  case digit(Int)
  case dot
  case op(Op)
  case command(Command)
}

extension CalculatorButtonItem {
  var title: String {
    switch self {
    case .digit(let value):
      return "\(value)"
    case .dot:
      return "."
    case .op(let op):
      return op.rawValue
    case .command(let command):
      return command.rawValue
    }
  }
  
  var size: CGSize {
    if case let .digit(value) = self, value == 0 {
      return CGSize(width: 88 * 2, height: 88)
    }
    return CGSize(width: 88, height: 88)
  }
  
  var backgroundColorName: String {
    switch self {
    case .digit, .dot:
      return "digitBackground"
    case .op:
      return "operatorBackground"
    case .command:
      return "commandBackground"
    }
  }
}

extension CalculatorButtonItem: Hashable {}

extension CalculatorButtonItem: CustomStringConvertible {
  var description: String {
    return title
  }
}
