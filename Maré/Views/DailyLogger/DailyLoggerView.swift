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

    @AppStorage(UserProfile.usernameKey) private var username: String = ""
    @AppStorage(UserProfile.birthdayKey) private var birthdayInterval: Double = 0

    @Environment(\.modelContext) private var context

    @Query private var registers: [Mood]

    private var greeting: String {
        let base = UserProfile.greeting()
        return username.isEmpty ? base : "\(base), \(username)"
    }

    private var isBirthdayToday: Bool {
        UserProfile.isBirthdayToday(UserProfile.birthday(from: birthdayInterval))
    }

    private var hasRegisteredToday: Bool {
        registers.contains { register in
            Calendar.current.isDateInToday(register.date)
        }
    }

    let moods: [MoodEnum] = MoodEnum.allCases

    var body: some View {
        // Centers the content when it fits; scrolls when the window is short (e.g. a folded or split iPhone Duo).
        ViewThatFits(in: .vertical) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            ScrollView {
                content
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            }
        }
        .background { OceanBackground() }
    }

    private var content: some View {
        ZStack {
            if !isModalOpened {
                VStack(spacing: 16) {
                    Text(greeting)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)

                    if isBirthdayToday {
                        Label("Happy birthday! 🎂", systemImage: "gift.fill")
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .glassEffect(.regular, in: .capsule)
                    }

                    Button(hasRegisteredToday ? "Make Another Entry" : "How are you feeling today?") {
                        withAnimation(.bouncy) {
                            isModalOpened = true
                        }
                    }
                    .buttonStyle(.glassProminent)
                }
                .padding(.horizontal)
                .transition(.scale.combined(with: .opacity))
            } else {
                VStack(spacing: 25) {
                    Text(hasRegisteredToday ? "Having a Mood Swing?" : "How are you feeling today?")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)

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
                            .frame(maxWidth: 420, minHeight: 120, maxHeight: 150)
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
                .padding(.horizontal)
                .transition(.opacity.combined(with: .scale))
            }
        }
    }

    private func logMood() {
        let newRegister = Mood(
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
        .modelContainer(for: Mood.self, inMemory: true)
}
