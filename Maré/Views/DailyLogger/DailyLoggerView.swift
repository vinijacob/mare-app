//
//  DailyLoggerView.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftUI

struct DailyLoggerView: View {
    var body: some View {
        Text("Daily Logger")
        Text("Qual seu humor hoje?")
        Button() {
        } label: {
            Text("Cadastrar Humor")
        }
        .padding()
//        .background(Color.gray, in: RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    DailyLoggerView()
}
