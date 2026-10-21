//
//  RootView.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TabView {
            Tab("Daily Logger", systemImage: "note") {
                DailyLoggerView()
            }
            
            Tab("Logs", systemImage: "clock.fill") {
                UserLogsView()
            }

            Tab("Profile", systemImage: "person.crop.circle.fill") {
                ProfileView()
            }
        }
        // Shows a tab bar when folded and can become a sidebar when the iPhone Duo unfolds.
        .tabViewStyle(.sidebarAdaptable)
        .tint(OceanTheme.accent(for: colorScheme))
    }
}

#Preview {
    RootView()
        .modelContainer(for: Mood.self, inMemory: true)
}
