//
//  RootView.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Daily Logger", systemImage: "note") {
                DailyLoggerView()
            }
            
            Tab("Logs", systemImage: "clock.fill") {
                Text("Registered Logs")
            }
        }
    }
}

#Preview {
    RootView()
}
