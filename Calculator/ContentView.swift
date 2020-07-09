//
//  ContentView.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/8.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 12) {
      Spacer()
      Text("0")
        .font(.system(size: 76))
        .minimumScaleFactor(0.5)
        .padding(.trailing, 24)
        .lineLimit(1)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
      CalculatorButtonPad()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
