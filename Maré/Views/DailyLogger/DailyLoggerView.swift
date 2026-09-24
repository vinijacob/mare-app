//
//  DailyLoggerView.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import SwiftData
import SwiftUI

struct DailyLoggerView: View {
    @State private var selectedMood: MoodEnum = .allCases.randomElement()!
    @State private var hasSelectedMood = false
    @State private var comment: String = ""
    
    let moods: [MoodEnum] = MoodEnum.allCases

    var body: some View {
        VStack(spacing: 25) {
            Text("How are you feeling today?")
            Picker("Mood Picker", selection: $selectedMood) {
                ForEach(moods) { mood in
                    HStack {
                        Text("\(mood.rawValue)")
                            .multilineTextAlignment(.center)
                            .tag(mood)

                        Spacer()

                        Text("\(mood.emoji)")
                    }
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 250, maxHeight: 180)
            .onChange(of: selectedMood) {
                withAnimation {
                    hasSelectedMood = true
                }
            }

            Button {
                // Register Mood
            } label: {
                Text(hasSelectedMood ? "Register Mood" : " ")
            }
            .buttonStyle(.glassProminent)
            .tint(.purple)
            .opacity(hasSelectedMood ? 1 : 0)

            VStack(spacing: 5) {
                ZStack(alignment: .topLeading) {
                    if comment.isEmpty {
                        Text(selectedMood.commentPlaceholder)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                    }
                    
                    TextEditor(text: $comment)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                }
                .padding()
                .frame(width: 300, height: 150)
                .glassEffect(.regular, in: .rect(cornerRadius: 20))
                .opacity(hasSelectedMood ? 1 : 0)
                .disabled(!hasSelectedMood)
                
                Text(hasSelectedMood ? "Want to comment about?" : " ")
                    .foregroundStyle(.foreground)
                    .italic()
            }
        }
    }
}

#Preview {
    DailyLoggerView()
}
