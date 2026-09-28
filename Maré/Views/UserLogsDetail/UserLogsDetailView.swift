//
//  UserLogsDetail.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 28/09/26.
//

import SwiftUI
import SwiftData

struct UserLogsDetail: View {
    @Bindable var userLog: Mood
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let isNew: Bool
    
    init(userLog: Mood, isNew: Bool = false) {
        self.userLog = userLog
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            Section("Mood: \(userLog.currentMood.rawValue)") {
                HStack(spacing: 12) {
                    Menu {
                        Picker("Mood", selection: $userLog.currentMood) {
                            ForEach(MoodEnum.allCases) { mood in
                                Text("\(mood.emoji) \(mood.rawValue)")
                                    .tag(mood)
                            }
                        }
                    } label: {
                        Text(userLog.currentMood.emoji)
                            .font(.largeTitle)
                    }
                    
                    TextField(userLog.currentMood.commentPlaceholder, text: $userLog.comment, axis: .vertical)
                }
            }
            
            Section("Date") {
                LabeledContent("Day", value: userLog.date.formatted(date: .long, time: .omitted))
                LabeledContent("Time", value: userLog.date.formatted(date: .omitted, time: .shortened))
            }
        }
        .navigationTitle(isNew ? "New Record" : "Record")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        context.delete(userLog)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UserLogsDetail(
        userLog: Mood(
            currentMood: .happy,
            comment: "Feel fine today!"
        )
    )
    .modelContainer(for: Mood.self, inMemory: true)
}
