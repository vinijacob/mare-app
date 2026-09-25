//
//  RootView.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Daily Logger", systemImage: "note") {
                DailyLoggerView()
            }
            
            Tab("Logs", systemImage: "clock.fill") {
                UserLogsView()
            }
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: MoodRegister.self, inMemory: true)
}
