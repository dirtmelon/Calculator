//
//  CalculatorButton.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/9.
//

import SwiftUI

struct CalculatorButton: View {
  let fontSize: CGFloat = 38
  let title: String
  let size: CGSize
  let backgroundColorName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action, label: {
      Text(title)
        .font(.system(size: fontSize))
        .foregroundColor(.white)
        .frame(width: size.width, height: size.height)
        .background(Color(backgroundColorName))
        .cornerRadius(size.width / 2)
    })
  }
}

struct CalculatorButton_Previews: PreviewProvider {
  static var previews: some View {
    CalculatorButton(title: "+",
                     size: CGSize(width: 160, height: 80),
                     backgroundColorName: "operatorBackground",
                     action: {
                     })
  }
}
