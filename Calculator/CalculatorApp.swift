//
//  CalculatorApp.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/8.
//

import SwiftUI

@main
struct CalculatorApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(CalculatorModel())
    }
  }
}
