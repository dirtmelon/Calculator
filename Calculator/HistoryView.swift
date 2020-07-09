//
//  HistoryView.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/9.
//

import SwiftUI

struct HistoryView: View {
  @EnvironmentObject var model: CalculatorModel
  @Binding var editingHistory: Bool
  var body: some View {
    VStack {
      if model.totalCount == 0 {
        Text("没有履历")
      } else {
        HStack {
          Text("履历").font(.headline)
          Text("\(model.historyDetail)").lineLimit(nil)
        }
        HStack {
          Text("显示").font(.headline)
          Text("\(model.brain.output)")
        }
        Slider(value: $model.slidingIndex,
               in: 0...Float(model.totalCount),
               step: 1)
        Button("关闭") {
          editingHistory = false
        }
      }
    }.padding()
  }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
      HistoryView(editingHistory: .constant(true)).environmentObject(CalculatorModel())
    }
}
