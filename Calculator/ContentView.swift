//
//  ContentView.swift
//  Calculator
//
//  Created by liguofeng on 2020/7/8.
//

import SwiftUI
import Combine

struct ContentView: View {
  @EnvironmentObject var model: CalculatorModel
  @State private var editingHistory = false
  @State private var showingResult = false
  var body: some View {
    VStack(spacing: 12) {
      Spacer()
      Button("操作履历: \(model.history.count)") {
        editingHistory = true
      }.sheet(isPresented: $editingHistory) {
        HistoryView(editingHistory: $editingHistory).environmentObject(model)
      }
      Text(model.brain.output)
        .font(.system(size: 76))
        .minimumScaleFactor(0.5)
        .padding(.trailing, 24)
        .lineLimit(1)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        .onTapGesture {
          showingResult = true
        }.alert(isPresented: $showingResult) {
          return Alert(title: Text(model.historyDetail),
                       message: Text(model.brain.output),
                       primaryButton: Alert.Button.cancel(Text("取消")),
                       secondaryButton: Alert.Button.default(Text("复制"), action: {
                        UIPasteboard.general.string = model.historyDetail + model.brain.output
                       }))
        }
      CalculatorButtonPad()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(CalculatorModel())
  }
}
