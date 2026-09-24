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
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: MoodRegister.self)
    }
}
