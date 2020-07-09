//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/9.
//

import Foundation

enum CalculatorBrain {
  case left(String)
  case leftOp(left: String, op: CalculatorButtonItem.Op)
  case leftOpRight(left: String, op: CalculatorButtonItem.Op, right: String)
  case error
  
  var output: String {
    let result: String
    switch self {
    case .left(let left):
      result = left
    case .leftOp(let left, _):
      result = left
    case .leftOpRight(_, _, let right):
      result = right
    case .error:
      return "Error"
    }
    guard let value = Double(result) else {
      return "Error"
    }
    return formatter.string(from: value as NSNumber)!
  }
  
  @discardableResult
  func apply(item: CalculatorButtonItem) -> CalculatorBrain {
    switch item {
    case .digit(let num):
      return apply(num: num)
    case .dot:
      return applyDot()
    case .op(let op):
      return apply(op: op)
    case .command(let command):
      return apply(command: command)
    }
  }
  
  private func apply(num: Int) -> CalculatorBrain {
    switch self {
    case .left(let left):
      return .left(left.apply(num: num))
    case .leftOp(let left, let op):
      return .leftOpRight(left: left, op: op, right: "0".apply(num: num))
    case .leftOpRight(let left, let op, let right):
      return .leftOpRight(left: left, op: op, right: right.apply(num: num))
    case .error:
      return .left("0".apply(num: num))
    }
  }
  
  private func applyDot() -> CalculatorBrain {
    switch self {
    case .left(let left):
      return .left(left.applyDot())
    case .leftOp(let left, let op):
      return .leftOpRight(left: left, op: op, right: "0".applyDot())
    case .leftOpRight(let left, let op, let right):
      return .leftOpRight(left: left, op: op, right: right.applyDot())
    case .error:
      return .left("0".applyDot())
    }
  }
  
  private func apply(op: CalculatorButtonItem.Op) -> CalculatorBrain {
    switch self {
    case .left(let left):
      switch op {
      case .plus, .minus, .multiply, .divide:
        return .leftOp(left: left, op: op)
      case .equal:
        return self
      }
    case .leftOp(let left, let currentOp):
      switch op {
      case .plus, .minus, .multiply, .divide:
        return .leftOp(left: left, op: op)
      case .equal:
        if let result = currentOp.calculate(left: left, right: left) {
          return .leftOp(left: result, op: currentOp)
        } else {
          return .error
        }
      }
    case .leftOpRight(let left, let currentOp, let right):
      switch op {
      case .plus, .minus, .multiply, .divide:
        if let result = currentOp.calculate(left: left, right: right) {
          return .leftOp(left: result, op: op)
        } else {
          return .error
        }
      case .equal:
        if let result = currentOp.calculate(left: left, right: right) {
          return .left(result)
        } else {
          return .error
        }
      }
    case .error:
      return self
    }
  }
  
  private func apply(command: CalculatorButtonItem.Command) -> CalculatorBrain {
    switch command {
    case .clear:
      return .left("0")
    case .flip:
      switch self {
      case .left(let left):
        return .left(left.flipped())
      case .leftOp(let left, let op):
        return .leftOpRight(left: left, op: op, right: "-0")
      case .leftOpRight(let left, let op, let right):
        return .leftOpRight(left: left, op: op, right: right.flipped())
      case .error:
        return .left("-0")
      }
    case .percent:
      switch self {
      case .left(let left):
        return .left(left.percentaged())
      case .leftOp:
        return self
      case .leftOpRight(left: let left, let op, let right):
        return .leftOpRight(left: left, op: op, right: right.percentaged())
      case .error:
        return .left("-0")
      }
    }
  }
}

var formatter: NumberFormatter = {
  let formatter = NumberFormatter()
  formatter.minimumFractionDigits = 0
  formatter.maximumFractionDigits = 8
  formatter.numberStyle = .decimal
  return formatter
}()

extension String {
  var containsDot: Bool {
    contains(".")
  }
  
  var startWithNegative: Bool {
    starts(with: "-")
  }
  
  func apply(num: Int) -> String {
    self == "0" ? "\(num)" : "\(self)\(num)"
  }
  
  func applyDot() -> String {
    containsDot ? self : "\(self)."
  }
  
  func flipped() -> String {
    if startWithNegative {
      var result = self
      result.removeFirst()
      return result
    }
    return "-\(self)"
  }
  
  func percentaged() -> String {
    return String(Double(self)! / 100)
  }
}

extension CalculatorButtonItem.Op {
  
  func calculate(left: String, right: String) -> String? {
    guard let left = Double(left),
          let right = Double(right) else {
      return nil
    }
    let result: Double?
    switch self {
    case .plus:
      result = left + right
    case .minus:
      result = left - right
    case .multiply:
      result = left * right
    case .divide:
      result = right == 0 ? nil : left / right
    case .equal:
      fatalError()
    }
    return result.map { String($0) }
  }
}
