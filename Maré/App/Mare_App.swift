//
//  Mare_App.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftUI
import SwiftData

@main
struct Mare_App: App {
    @AppStorage(UserProfile.appearanceKey) private var appearance: AppAppearance = .system

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(appearance.colorScheme)
        }
        .modelContainer(for: Mood.self)
    }
}
