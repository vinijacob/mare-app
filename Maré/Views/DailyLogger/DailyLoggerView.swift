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
    @State private var comment: String = ""
    @State private var isModalOpened: Bool = false

    @Environment(\.modelContext) private var context

    @Query private var registers: [MoodRegister]

    private var hasRegisteredToday: Bool {
        registers.contains { register in
            Calendar.current.isDateInToday(register.date)
        }
    }

    let moods: [MoodEnum] = MoodEnum.allCases

    var body: some View {
        ZStack {
            if !isModalOpened {
                Button(hasRegisteredToday ? "Make Another Entry" : "How are you feeling today?") {
                    withAnimation(.bouncy) {
                        isModalOpened = true
                    }
                }
                .buttonStyle(.glassProminent)
                .tint(.blue)
                .transition(.scale.combined(with: .opacity))
            } else {
                VStack(spacing: 25) {
                    Text(hasRegisteredToday ? "Having a Mood Swing?" : "How are you feeling today?")
                        .font(.largeTitle.bold())

                    Text("Pick a mood")
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Picker("Mood Picker", selection: $selectedMood) {
                        ForEach(moods) { mood in
                            HStack {
                                Text(mood.rawValue)
                                    .multilineTextAlignment(.center)
                                    .tag(mood)

                                Text(mood.emoji)
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: 280, maxHeight: 180)
                    .onChange(of: selectedMood) {
                        withAnimation {
                            hasSelectedMood = true
                        }
                    }

                    if hasSelectedMood {
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
                            .frame(width: 280, height: 150)
                            .glassEffect(.regular, in: .rect(cornerRadius: 20))

                            Text("Want to comment about?")
                                .foregroundStyle(.foreground)
                                .italic()
                        }

                        Button {
                            logMood()
                        } label: {
                            Text("Register Mood")
                        }
                        .buttonStyle(.glassProminent)
                        .tint(selectedMood.color)
                        .transition(.scale)
                    }
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func logMood() {
        let newRegister = MoodRegister(
            currentMood: selectedMood,
            comment: comment
        )

        context.insert(newRegister)

        comment = ""
        hasSelectedMood = false
        withAnimation(.bouncy) {
            isModalOpened = false
        }
    }
}

#Preview {
    DailyLoggerView()
        .modelContainer(for: MoodRegister.self, inMemory: true)
}
