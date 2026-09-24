//
//  sourcecode.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftData
import SwiftUI

struct DailyLoggerView: View {
    @State private var selectedMood: MoodEnum = .allCases.randomElement()!
    @State private var hasSelectedMood = false

    var body: some View {
        VStack(spacing: 25) {
            Text("Como está seu humor hoje?")
            Picker("Mood Picker", selection: $selectedMood) {
                ForEach(MoodEnum.allCases) { mood in
                    Text("\(mood.rawValue)")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .tag(mood)
                }
            }
            .pickerStyle(.wheel)
            .padding()
            .onChange(of: selectedMood) {
                hasSelectedMood = true
            }

            if hasSelectedMood {
                Button {} label: {
                    Text("Registrar Humor")
                }
            } else {
                Button {} label: {
                    Text(" ")
                }
            }
        }
    }
}

#Preview {
    DailyLoggerView()
}
